disable_displayport_out = {
  matches = {
    {
      { "device.name", "equals", "alsa_card.pci-0000_01_00.1" }
    }
  },
  apply_properties = {
    ["device.disabled"] = true
  }
}

disable_rode_out = {
  matches = {
    {
      { "node.name", "matches", "alsa_output.usb-R__DE_Microphones_R__DE_NT-USB_Mini_EA6699D1-00.analog-stereo" }
    }
  },
  apply_properties = {
    ["node.disabled"] = true
  }
}

disable_sound_blaster_in = {
  matches = {
    {
      { "node.name", "matches", "alsa_input.usb-Creative_Technology_Ltd_Sound_Blaster_X7_X000009u-00.analog-stereo" }
    }
  },
  apply_properties = {
    ["node.disabled"] = true
  }
}

disable_sound_blaster_suspend = {
  matches = {
    {
      { "node.name", "matches", "alsa_output.usb-Creative_Technology_Ltd_Sound_Blaster_X7" }
    }
  },
  apply_properties = {
    ["session.suspend-timeout-seconds"] = 0
  }
}
table.insert(alsa_monitor.rules, disable_displayport_out)
table.insert(alsa_monitor.rules, disable_rode_out)
table.insert(alsa_monitor.rules, disable_sound_blaster_in)
table.insert(alsa_monitor.rules, disable_sound_blaster_suspend)
