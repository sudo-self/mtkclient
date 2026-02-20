#!/bin/bash

# --- MTK FRP Bypass & Root Guide Tool ---
# JR TOOLS v2.2 - macOS Edition

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
BOLD='\033[1m'
NC='\033[0m' 

# Visual Headers
draw_logo() {
    clear
    echo -e "${BLUE}${BOLD}=================================================================${NC}"
    echo -e "${CYAN}${BOLD}                    MTK FRP BYPASS + ROOT                        ${NC}"
    echo -e "${BLUE}${BOLD}=================================================================${NC}"
    echo -e ""
    echo -e "${WHITE}${BOLD}                    ╔══════════════════╗${NC}"
    echo -e "${WHITE}${BOLD}                    ║     JR TOOLS     ║${NC}"
    echo -e "${WHITE}${BOLD}                    ╚══════════════════╝${NC}"
    echo -e ""
    echo -e "${PURPLE}                    ╔═══╗╔═══╗╔═══╗╔═══╗╔═══╗${NC}"
    echo -e "${PURPLE}                    ║ J ║║ R ║║ M ║║ T ║║ K ║${NC}"
    echo -e "${PURPLE}                    ╚═══╝╚═══╝╚═══╝╚═══╝╚═══╝${NC}"
    echo -e ""
    echo -e "${BLUE}=================================================================${NC}"
}

jr_section() {
    local title="$1"
    echo -e ""
    echo -e "${PURPLE}   ╔══════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}   ║     ${WHITE}${BOLD}JR • $title${NC}${PURPLE}          ║${NC}"
    echo -e "${PURPLE}   ╚══════════════════════════════════════╝${NC}"
    echo -e ""
}

jr_success() {
    echo -e ""
    echo -e "${GREEN}                 ╔══════════════════╗${NC}"
    echo -e "${GREEN}                 ║  ✅ SUCCESS!     ║${NC}"
    echo -e "${GREEN}                 ╚══════════════════╝${NC}"
    echo -e "${GREEN}                   JR TOOLS v2.2${NC}"
    echo -e ""
}

# Environment Logic
check_env() {
    jr_section "ENVIRONMENT SETUP"
    echo -e "${YELLOW}[!] Checking macOS Requirements...${NC}"
    
    # libusb is mandatory for mtkclient on Mac
    if ! command -v brew &> /dev/null; then
        echo -e "${RED}[!] Homebrew not found. Install it: https://brew.sh${NC}"
        exit 1
    fi

    if ! brew list libusb >/dev/null 2>&1; then
        echo -e "${CYAN}[*] Installing libusb via Homebrew...${NC}"
        brew install libusb
    fi

    if [ ! -d "bin" ]; then
        echo -e "${CYAN}[*] Creating virtual environment...${NC}"
        python3 -m venv .
        source bin/activate
        pip install --upgrade pip
        pip install pyusb pyserial pycryptodome
    else
        source bin/activate
    fi
    echo -e "${GREEN}[+] Environment ready.${NC}"
}

wait_for_brom() {
    echo -e ""
    echo -e "${CYAN}              ╔════════════════════════╗${NC}"
    echo -e "${CYAN}              ║   🔧 BROM MODE ACTIVE  ║${NC}"
    echo -e "${CYAN}              ╚════════════════════════╝${NC}"
    echo -e ""
    echo -e "${WHITE}1. Power OFF device.${NC}"
    echo -e "${WHITE}2. Hold ${BOLD}Volume Up + Volume Down${NC}${WHITE}.${NC}"
    echo -e "${WHITE}3. Connect USB to Mac.${NC}"
    echo -e ""
    echo -e "${YELLOW}Press [Enter] once the device is connected.${NC}"
    read -r
}

# FRP Bypass
frp_bypass() {
    jr_section "FRP BYPASS"
    check_env
    wait_for_brom
    
    echo -e "${CYAN}[*] Attempting Bootloader Unlock (Temp)...${NC}"
    python3 mtk.py da seccfg unlock
    
    echo -e "${CYAN}[*] Erasing FRP/Persist Partitions...${NC}"
    # Standard and Extended FRP partitions for MTK
    python3 mtk.py e frp
    python3 mtk.py e persist
    python3 mtk.py e persistence
    
    python3 mtk.py reset
    jr_success
}

# Rooting Logic
root_device() {
    jr_section "ROOT GUIDE"
    echo -e "${RED}${BOLD}!!! WARNING: DATA WIPE REQUIRED !!!${NC}"
    check_env

    wait_for_brom
    echo -e "${CYAN}[*] Unlocking Bootloader...${NC}"
    python3 mtk.py da seccfg unlock
    python3 mtk.py reset
    
    echo -e "${YELLOW}[!] Device is wiping. Boot up and enable USB Debugging.${NC}"
    echo "Press [Enter] when phone is back on with Debugging active."
    read -r

    wait_for_brom
    echo -e "${CYAN}[*] Dumping Boot & VBMeta...${NC}"
    python3 mtk.py r boot,vbmeta boot.img,vbmeta.img
    python3 mtk.py reset
    
    echo -e "${YELLOW}[*] Pushing boot.img to phone...${NC}"
    adb push boot.img /sdcard/Download/
    
    echo -e "${PURPLE}--> Patch /Download/boot.img in Magisk app.${NC}"
    echo -n "Enter the patched filename (magisk_patched_xxxxx.img): "
    read -r patched_name
    
    adb pull "/sdcard/Download/$patched_name" boot.patched
    
    wait_for_brom
    echo -e "${CYAN}[*] Flashing Patched Boot & Disabling VBMeta...${NC}"
    python3 mtk.py da vbmeta 3
    python3 mtk.py w boot boot.patched
    python3 mtk.py reset
    
    jr_success
}

# Menu Loop
while true; do
    draw_logo
    echo -e "${BLUE}${BOLD}╔════════════════════════════════════╗${NC}"
    echo -e "${BLUE}${BOLD}║       WHAT WOULD YOU LIKE TO DO?   ║${NC}"
    echo -e "${BLUE}${BOLD}╚════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${CYAN} 1) FRP Bypass Only (Google Lock)${NC}"
    echo -e "${PURPLE} 2) Root Device (Magisk Method)${NC}"
    echo -e "${YELLOW} 3) Environment Setup Only${NC}"
    echo -e "${RED} 4) Exit Tool${NC}"
    echo ""
    echo -n -e "${GREEN}Enter choice [1-4]: ${NC}"
    read -r opt

    case $opt in
        1) frp_bypass ;;
        2) root_device ;;
        3) check_env ;;
        4) 
            echo -e "${RED}Exiting JR Tools...${NC}"
            exit 0 
            ;;
        *) 
            echo -e "${RED}Invalid Choice!${NC}"
            sleep 1
            ;;
    esac

    echo -e "${YELLOW}Press Enter to return to Menu...${NC}"
    read -r
done
