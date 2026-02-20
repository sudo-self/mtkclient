#!/bin/bash

# --- MTK FRP Bypass & Root Guide Tool ---


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

# JR ASCII
clear
echo -e "${BLUE}${BOLD}=================================================================${NC}"
echo -e "${CYAN}${BOLD}                    MTK FRP BYPASS + ROOT                       ${NC}"
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
echo -e "${CYAN}          ╔══════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}          ║     MediaTek Flash/Exploit Client v2.0.1    ║${NC}"
echo -e "${CYAN}          ║         FRP Bypass & Root Guide Tool        ║${NC}"
echo -e "${CYAN}          ╚══════════════════════════════════════════════╝${NC}"
echo -e ""
echo -e "${GREEN}                      [✓] dark mode enabled${NC}"
echo -e "${YELLOW}                      [⚠] root guide included${NC}"
echo -e "${BLUE}=================================================================${NC}"
echo ""


jr_section() {
    local title="$1"
    echo -e ""
    echo -e "${PURPLE}   ╔══════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}   ║     ${WHITE}${BOLD}JR • $title${NC}${PURPLE}        ║${NC}"
    echo -e "${PURPLE}   ╚══════════════════════════════════════╝${NC}"
    echo -e ""
}

jr_success() {
    echo -e ""
    echo -e "${GREEN}                 ╔══════════════════╗${NC}"
    echo -e "${GREEN}                 ║  ✅ SUCCESS!    ║${NC}"
    echo -e "${GREEN}                 ╚══════════════════╝${NC}"
    echo -e "${GREEN}                   JR TOOLS v1.0${NC}"
    echo -e ""
}


jr_warning() {
    echo -e ""
    echo -e "${YELLOW}                 ╔══════════════════╗${NC}"
    echo -e "${YELLOW}                 ║  ⚠️  WARNING!    ║${NC}"
    echo -e "${YELLOW}                 ╚══════════════════╝${NC}"
    echo -e "${YELLOW}              Proceed with caution${NC}"
    echo -e ""
}

jr_brom() {
    echo -e ""
    echo -e "${CYAN}              ╔════════════════════════╗${NC}"
    echo -e "${CYAN}              ║  🔧 BROM MODE ACTIVE  ║${NC}"
    echo -e "${CYAN}              ╚════════════════════════╝${NC}"
    echo -e "${CYAN}                 [JR] waiting...${NC}"
    echo -e ""
}


check_env() {
    jr_section "ENVIRONMENT SETUP"
    echo -e "${YELLOW}[!] Checking Environment Setup...${NC}"
    if [ ! -d "bin" ]; then
        echo -e "${CYAN}[*] Creating virtual environment...${NC}"
        python3 -m venv .
    fi
    echo -e "${CYAN}[*] Activating virtual environment...${NC}"
    source bin/activate
    echo -e "${GREEN}[+] Environment ready.${NC}"
    jr_success
}


wait_for_brom() {
    jr_brom
    echo -e "${PURPLE}${BOLD}╔════════════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}${BOLD}║     ACTION REQUIRED: ENTER BROM MODE      ║${NC}"
    echo -e "${PURPLE}${BOLD}╚════════════════════════════════════════════╝${NC}"
    echo -e ""
    echo -e "${WHITE}1. Power off the phone completely.${NC}"
    echo -e "${WHITE}2. Hold ${BOLD}Volume Up + Volume Down${NC}${WHITE} simultaneously.${NC}"
    echo -e "${WHITE}3. While holding, connect USB cable to PC.${NC}"
    echo -e ""
    echo -e "${YELLOW}   ╔════════════════════════════╗${NC}"
    echo -e "${YELLOW}   ║  Press Enter when ready   ║${NC}"
    echo -e "${YELLOW}   ╚════════════════════════════╝${NC}"
    read -r
}

# FRP Bypass
frp_bypass() {
    jr_section "FRP BYPASS"
    echo -e "${YELLOW}[*] Starting FRP Bypass process...${NC}"
    
    wait_for_brom
    echo -e "${CYAN}╔════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║  [1/5] Unlocking Bootloader...    ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════╝${NC}"
    python3 mtk.py da seccfg unlock
    
    wait_for_brom
    echo -e "${CYAN}╔════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║  [2/5] Listing partitions...      ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════╝${NC}"
    python3 mtk.py rl list
    
    echo -e "${CYAN}╔════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║  [3/5] Erasing FRP partitions...  ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════╝${NC}"
    python3 mtk.py e frp
    python3 mtk.py e protect1
    python3 mtk.py e protect2
    python3 mtk.py e persistence
    
    echo -e "${CYAN}╔════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║  [4/5] Resetting device...        ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════╝${NC}"
    python3 mtk.py reset
    
    echo -e "${CYAN}╔════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║  [5/5] FRP Bypass Complete!       ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════╝${NC}"
    jr_success
}

# Rooting Logic
root_device() {
    jr_section "ROOT GUIDE"
    jr_warning
    echo -e "${RED}${BOLD}╔══════════════════════════════════════════╗${NC}"
    echo -e "${RED}${BOLD}║  !!! WARNING: ROOTING WILL WIPE DATA !!! ║${NC}"
    echo -e "${RED}${BOLD}╚══════════════════════════════════════════╝${NC}"
    echo -e "Ensure OEM Unlocking and USB Debugging are enabled."
    echo ""
    
    # Step 1
    wait_for_brom
    echo -e "${CYAN}╔════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║  [1/5] Unlocking Bootloader...    ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════╝${NC}"
    python3 mtk.py da seccfg unlock
    python3 mtk.py reset
    
    # Step 2
    wait_for_brom
    echo -e "${CYAN}╔════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║  [2/5] Dumping Stock Boot/VBmeta  ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════╝${NC}"
    python3 mtk.py r boot,vbmeta boot.img,vbmeta.img
    python3 mtk.py reset
    
    # Step 3
    echo -e "${CYAN}╔════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║  [3/5] Magisk Patching            ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════╝${NC}"
    echo -e "${YELLOW}[!] Transferring boot.img to phone...${NC}"
    adb push boot.img /sdcard/Download/
    echo ""
    echo -e "${PURPLE}${BOLD}╔════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}${BOLD}║     MANUAL STEP ON PHONE          ║${NC}"
    echo -e "${PURPLE}${BOLD}╚════════════════════════════════════╝${NC}"
    echo -e "1. Install Magisk APK."
    echo -e "2. Open Magisk -> Install -> Select and Patch a File."
    echo -e "3. Select /sdcard/Download/boot.img."
    echo -e "4. Once finished, note the filename in Downloads."
    echo ""
    echo -e "${YELLOW}Enter the exact name of the patched file (magisk_patched-xxxxx.img):${NC}"
    echo -e "${CYAN}╔════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║  Type filename below:             ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════╝${NC}"
    read -r patched_name
    
    adb pull "/sdcard/Download/$patched_name" boot.patched
    
    # Step 4
    wait_for_brom
    echo -e "${CYAN}╔════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║  [4/5] Disabling VBMeta...        ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════╝${NC}"
    python3 mtk.py da vbmeta 3
    
    echo -e "${CYAN}╔════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║  [4/5] Flashing patched boot...    ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════╝${NC}"
    python3 mtk.py w boot boot.patched
    
    # Handle A/B slots if necessary (informational)
    echo -e "${YELLOW}[i] If this is an A/B device, you may need to flash boot_a and boot_b manually.${NC}"
    
    # Step 5
    echo -e "${CYAN}╔════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║  [5/5] Rebooting...               ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════╝${NC}"
    python3 mtk.py reset
    
    echo -e ""
    echo -e "${GREEN}╔══════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║  ✅ ROOTING COMPLETE!                   ║${NC}"
    echo -e "${GREEN}║  Check Magisk app after reboot          ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════╝${NC}"
    echo -e "${GREEN}                    JR TOOLS v1.0${NC}"
    echo -e ""
}

# Exit Animation
jr_exit() {
    clear
    echo -e "${PURPLE}"
    echo -e "   ╔══════════════════════════════════════════╗"
    echo -e "   ║     THANK YOU FOR USING JR TOOLS        ║"
    echo -e "   ╚══════════════════════════════════════════╝"
    echo -e ""
    echo -e "       ╔═══╗╔═══╗   ╔════╗╔═══╗╔═══╗╔═══╗"
    echo -e "       ║ J ║║ R ║   ║ MTK║║ F ║║ R ║║ P ║"
    echo -e "       ╚═══╝╚═══╝   ╚════╝╚═══╝╚═══╝╚═══╝"
    echo -e ""
    echo -e "${NC}"
    sleep 1
}

#  Menu 
initial_menu() {
    echo -e "${BLUE}${BOLD}╔════════════════════════════════════╗${NC}"
    echo -e "${BLUE}${BOLD}║      WHAT WOULD YOU LIKE TO DO?    ║${NC}"
    echo -e "${BLUE}${BOLD}╚════════════════════════════════════╝${NC}"
    echo -e ""
    echo -e "${WHITE}Select an option:${NC}"
    echo -e "${CYAN}   ┌─────────────────────────────────┐${NC}"
    echo -e "${CYAN}   │  ${WHITE}1)${CYAN} FRP Bypass Only              │${NC}"
    echo -e "${CYAN}   │     ${GREEN}(Remove Google Account Lock)   ${CYAN}│${NC}"
    echo -e "${CYAN}   │                                 │${NC}"
    echo -e "${CYAN}   │  ${WHITE}2)${CYAN} Root Device                  │${NC}"
    echo -e "${CYAN}   │     ${PURPLE}(Full Root + Magisk)          ${CYAN}│${NC}"
    echo -e "${CYAN}   │                                 │${NC}"
    echo -e "${CYAN}   │  ${WHITE}3)${CYAN} Environment Setup Only       │${NC}"
    echo -e "${CYAN}   │     ${YELLOW}(Setup venv & dependencies)   ${CYAN}│${NC}"
    echo -e "${CYAN}   │                                 │${NC}"
    echo -e "${CYAN}   │  ${WHITE}4)${CYAN} Exit                        │${NC}"
    echo -e "${CYAN}   └─────────────────────────────────┘${NC}"
    echo ""
    

    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${WHITE}Quick Info:${NC}"
    echo -e "${GREEN}• FRP Bypass${NC} - Removes Google account lock, keeps data"
    echo -e "${PURPLE}• Root Device${NC} - Full root access, WIPES ALL DATA"
    echo -e "${YELLOW}• Environment${NC} - Just sets up Python venv"
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    
    echo -n -e "${GREEN}Enter your choice [1-4]: ${NC}"
    read -r opt

    case $opt in
        1)
            echo -e "${CYAN}Selected: FRP Bypass Only${NC}"
            sleep 1
            check_env
            frp_bypass
            ;;
        2)
            echo -e "${PURPLE}Selected: Root Device${NC}"
            sleep 1
            check_env
            root_device
            ;;
        3)
            echo -e "${YELLOW}Selected: Environment Setup Only${NC}"
            sleep 1
            check_env
            echo -e "${GREEN}[+] Environment setup complete!${NC}"
            ;;
        4)
            echo -e "${RED}Exiting...${NC}"
            sleep 1
            jr_exit
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid option. Please choose 1-4.${NC}"
            sleep 2
            initial_menu
            ;;
    esac
    

    echo ""
    echo -e "${YELLOW}════════════════════════════════════════════════${NC}"
    echo -e "${YELLOW}Press Enter to return to main menu...${NC}"
    read -r
    initial_menu
}


initial_menu
