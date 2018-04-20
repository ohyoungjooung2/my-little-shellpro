#!/usr/bin/env bash
cpu_usage(){
echo -e "\e[33m Cpu usage guess sy+us+id==CPU TIME SPENT CALCULATE \e[0m"
echo " "
echo "us: user cpu time (or) % CPU time spent in user space
sy: system cpu time (or) % CPU time spent in kernel space
ni: user nice cpu time (or) % CPU time spent on low priority processes
id: idle cpu time (or) % CPU time spent idle
wa: io wait cpu time (or) % CPU time spent in wait (on disk)
hi: hardware irq (or) % CPU time spent servicing/handling hardware interrupts
si: software irq (or) % CPU time spent servicing/handling software interrupts
st: steal time - - % CPU time in involuntary wait by virtual cpu while hypervisor is servicing another processor (or) % CPU time stolen from a virtual machine"
echo " "
echo -e "\e[33m Iterate 2 times \e[0m"
top -b -n2 | grep -i "cpu(s)"
top -b -n2 | grep -i "cpu(s)" | awk '{ print $2 + $4 + $6 }'
}

memory_usage(){
 echo -e  "\e[33m Memory_usage \e[0m"
 echo ""
 echo -e "\e[33m Iterate 2times actual memory \e[0m"
 top -b -n2 | grep -i "mem:"
 echo -e "\e[33m Iterate 2times swap memory \e[0m"
 top -b -n2 | grep -i "swap:"
 
}

cpu_usage
echo ""
memory_usage
