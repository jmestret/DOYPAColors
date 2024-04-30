# Color palettes for DOYPAColors package
#
# This file defines color palettes for various use cases, including sequential, 
# diverging, qualitative, and colorblind scenarios.

# Palette categories
doypa_sequential <- c("cool_blue", "doypa", "imares_blue", "imares_red")
doypa_diverging <- c("blue2red", "purple2green", "mir")
doypa_qualitative <- c("astro", "buzz", "cyberpunk", "deep", "earth", "goofy", 
                       "google", "groovy", "high_contrast", "nature", "retro", 
                       "rookie", "snack", "sunset", "tidy", "vaporwave", "vintage")
doypa_colorblind <- c("groovy")

# Assign palette names
names(doypa_sequential) <- doypa_sequential
names(doypa_diverging) <- doypa_diverging
names(doypa_qualitative) <- doypa_qualitative
names(doypa_colorblind) <- doypa_colorblind

# Color palettes list
doypa_pals <- list(
  ## Sequential Palettes - n = 9 colors
  cool_blue =      c("#e0ffff", "#c8e3ff", "#afc7ff", "#97abff", "#7e90ff", "#6674ff", "#4d58ff", "#353cff", "#1c20ff"),
  
  doypa =          c("#bceecb", "#91debc", "#67cdac", "#42ba9b", "#7f9d3a", "#d47200", "#d64b02", "#ba2314", "#880024"),
  
  imares_blue =    c("#aaf0e2", "#8fdbd4", "#73c5c6", "#58afb8", "#3c99aa", "#21839c", "#056d8e", "#005780", "#004172"),
  
  imares_red =     c("#ffcd7e", "#ffb073", "#ff9269", "#ff755e", "#e85754", "#cd3a49", "#b31c3f", "#990034", "#7e002a"),
  
  ## Diverging Palettes - n = 11 colors
  blue2red =       c("#232ba7", "#545ab9", "#8b8fce", "#bfc1e1", "#e6e6ef", "#f5f5f5", "#ede2e3", "#d8b0b4", "#bc6d74", "#9e2631", "#840000"),
  
  purple2green =   c("#70257e", "#90579a", "#b48ebb", "#d6c3d9", "#efeaf0", "#f9f9f9", "#e5ede9", "#b3cfbf", "#6fa687", "#277a4c", "#005417"),
  
  mir =            c("#006698", "#2395ad", "#61c4c1", "#96e1d2", "#cce9e5", "#f2ecee", "#ffdba9", "#ffb064", "#ff865b", "#e45355", "#b0214f"),
  
  ## Qualitative Palettes - no limit of colors
  astro =          c("#1D313C", "#F6733A", "#ECD6C3", "#4FA3AB", "#387654"),
  
  buzz =           c("#6036a4", "#9de26b", "#F5C290", "#B1B3B3", "#FF2400", "#ADD8E6"),
  
  cyberpunk =      c("#DFD828", "#61A059", "#085857", "#313638", "#ff2a6d", "#B0BA83"),
  
  deep =           c("#255e65", "#d9bea1", "#a2a8a9", "#a88565", "#3591a0"),
  
  earth =          c("#D52429", "#F1602C", "#EC8922", "#915018", "#6C3F18"),
  
  goofy =          c("#F58221", "#00AEEF", "#313638", "#F3D9CE", "#A6CE39"),
  
  google =         c("#4285F4", "#34A853", "#FBBC05", "#EA4335"),
  
  groovy =         c("#2BAF90", "#A1D4B1", "#F1A512", "#DD4111", "#8C0027"),
  
  high_contrast =  c("#00B5B0", "#00FF28", "#FFC700", "#FF0000", "#C70083", "#9500AC"),
  
  nature =         c("#228B22", "#8B4513", "#87CEEB", "#D2B48C", "#84CA67","#BF530D", "#376362"),
  
  retro =          c("#D54751", "#EF9A48", "#FFFCC7", "#4DA394", "#59322B"),
  
  rookie =         c("#ff7f00", "#ff4500", "#836fff", "#00ff7f", "#f9f9f9"),
  
  snack =          c("#0D1282", "#EEEDED", "#F0DE36", "#D71313"),
  
  sunset =         c("#FF4500", "#FF2400", "#FF007F", "#800080"),
  
  tidy =           c("#1C4EAA", "#E36C14", "#666667", "#ADD8E6", "#FBE870"),
  
  vaporwave =      c("#511940", "#F86A2A", "#07B7AD", "#0B60E1", "#E7C6AE")
)
