#!/usr/bin/env bash
hardware_check(){
  CV=$(egrep -c '(vmx|svm)' /proc/cpuinfo)
  if [[ $CV>=0 ]]
  then
    echo "This system supports hardware VIRTUALIZATION goood!"
  else
    echo "This system does not supports hardware VIRTUALIZATION plz check bios setting or etc"
  exit 1
  fi
}

kvm_install_check(){
  KVMOK=$(which kvm-ok)
  if [[ ! $KVMOK ]]
  then
     echo -e "\e[33m kvm-ok not installed. Installing cpu-checker\e[0m"
     apt install -y cpu-checker
  else
     echo -e "\e[36m kvm-ok installed\e[0m"
            
  fi
}

kvm_ok_check(){
  KOK=$(kvm-ok)
  if [[ $KOK ]]
  then
    echo -e "\e[36m $KOK \e[0m"
  else
    echo -e "\e[33m something wrong.Plz check bios or kernel options etc \e0m"
  fi
}
  

kvm_install_ubuntu(){
  echo -e "\e[36m Update system apt update -y\e0m"
  sudo apt-get update -y
  echo -e "\e[36m Installing qemu qemu-kvm libvirt-bin \e0m"
  sudo apt install -y qemu qemu-kvm libvirt-bin 
  echo -e "\e[36m Enabling libvirtd service \e0m"
  sudo systemctl enable libvirtd
  echo -e "\e[36m Starting libvirtd service \e0m"
  sudo systemctl start libvirtd
  sudo systemctl status libvirtd
}

hardware_check
kvm_install_check
kvm_ok_check
kvm_install_ubuntu
root@oyj-ThinkPad-E465:~# vi kvm_install_on_u18.sh 
root@oyj-ThinkPad-E465:~# ls
kvm_install_on_u18.sh
root@oyj-ThinkPad-E465:~# cat kvm_install_on_u18.sh 
#!/usr/bin/env bash
#This script is for development only. Can adjust on production if you understad 100%. 
hardware_check(){
  CV=$(egrep -c '(vmx|svm)' /proc/cpuinfo)
  if [[ $CV>=0 ]]
  then
    echo "This system supports hardware VIRTUALIZATION goood!"
  else
    echo "This system does not supports hardware VIRTUALIZATION plz check bios setting or etc"
  exit 1
  fi
}

kvm_install_check(){
  KVMOK=$(which kvm-ok)
  if [[ ! $KVMOK ]]
  then
     echo -e "\e[33m kvm-ok not installed. Installing cpu-checker\e[0m"
     apt install -y cpu-checker
  else
     echo -e "\e[36m kvm-ok installed\e[0m"
            
  fi
}

kvm_ok_check(){
  KOK=$(kvm-ok)
  if [[ $KOK ]]
  then
    echo -e "\e[36m $KOK \e[0m"
  else
    echo -e "\e[33m something wrong.Plz check bios or kernel options etc \e0m"
  fi
}
  

kvm_install_ubuntu(){
  echo -e "\e[36m Update system apt update -y\e0m"
  sudo apt-get update -y
  echo -e "\e[36m Installing qemu qemu-kvm libvirt-bin \e0m"
  sudo apt install -y qemu qemu-kvm libvirt-bin 
  echo -e "\e[36m Enabling libvirtd service \e0m"
  sudo systemctl enable libvirtd
  echo -e "\e[36m Starting libvirtd service \e0m"
  sudo systemctl start libvirtd
  sudo systemctl status libvirtd
}


hardware_check
kvm_install_check
kvm_ok_check
kvm_install_ubuntu
