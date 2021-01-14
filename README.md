 # TI59_battery - LiPo Battery for TI-58/59 Calculators
 
This is my attempt at a LiPo-based battery pack for Texas Instruments Calculators that use the BP01 battery pack,  specifically the TI-58, TI-58C, and TI-59. The original NiCd packs are all dead by now, and rebuilding them is difficult, mostly because it requires cutting apart and then carefully re-assembling the plastic battery retention frame. I thought it would be fun to design a 3D printed housing and re-use the circuitry from my rechargeable HP LiPo battery pack. 

> LiPo chemistry has very specific care-and-feeding when it comes to recharging, **the original charger and charging circuitry will not suffice.**  For this reason, I include a USB receptacle, which allows for charging when removed from the calculator.

The basic idea is to use a gold-flashed (ENIG) PCB as the contact substrate, and mount the LiPo, USB micro B receptacle, and charging circuitry on the opposite side. A **charging LED** is placed on the same side as the contact pads, but in areas where there will be no mechanical interference. A 3D printed plastic holder ties it all together, and mates with the TI calculator case. 
 
## The Housing
I  have several original TI BP01 battery packs, so I was able to measure it and create a 3D model using OpenSCAD. This is essentially a 3D solid 'programming language' which for me is much easier to work with than a 'real' 3D CAD program. 
TI-59_LiPo_holder_0v5 is the latest version of holder, to be verified when PCBs are available.

## The PCB 
The PCB holds the USB micro B connector, the charging circuitry, the protection circuitry, a connector for the LiPo battery, and most importantly the pads that mate with the contacts in the calculator.  The overall size of the PCB is 53mm x 28mm. The material is 1.6mm thick FR4. So that the contact pads do not  tarnish over time, I chose a gold-flash treatment (ENIG). 

The schematic and PCB were designed using KiCAD. Note that the PCB can accommodate either a JST or 0.1" two pin battery connector type
PCB is ordered from PCBWay on 1/14/2021

## The LiPo Battery
I wanted a 1S (3.7V) LiPo battery in the neighborhood of 1200mAhr that would fit within the confines of the original pack envelope. This led me to a size "103040" LiPo battery. I prefer the JST connector, so I found one with that connector type. The PCB can accommodate either JST or "two pin" connectors, so there's some flexibility here. 

## Putting It All Together
Pretty self-explanatory. I used 0805 size components to allow for easy hand-soldering. Note that D1 (LED) and Z1 (Zener) are both polarized, so pay attention to that. Soldering the USB connector requires a fine-tip iron and some patience. 

## Charge It
Connect a micro-B cable to the board and charge the LiPo battery. The LED will stay lit during the charging process, and extinguish when it is completed. The charge current is about 220mA (0.2C for a 1200mAhr battery). You can adjust R1 to change the current if you need to. It took about two hours to charge my battery,

## Use It!
Install the pack into the calculator, 




>January 14, 2021
>Tom LeMense
> Written with [StackEdit](https://stackedit.io/).
