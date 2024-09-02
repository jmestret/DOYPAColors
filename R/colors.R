# Color palettes for DOYPAColors package
#
# This file defines color palettes for various use cases, including sequential, 
# diverging, qualitative, and colorblind scenarios.

# Palette categories
doypa_sequential <- c("blue", "deep", "blue_purple", "purple", "yellow_green", 
                      "doypa_qual", "regal_blue", "blue_red", "red", "orange", 
                      "pink", "gray")
doypa_diverging <- c("blue2red", "purple2green", "mir")
doypa_qualitative <- c("astro", "buzz", "cyberpunk", "earth", "goofy", "google", 
                       "doypa", "high_contrast", "nature", "retro", "rookie", 
                       "snack", "sunset", "tidy", "vaporwave")
doypa_colorblind <- c("doypa")

# Assign palette names
names(doypa_sequential) <- doypa_sequential
names(doypa_diverging) <- doypa_diverging
names(doypa_qualitative) <- doypa_qualitative
names(doypa_colorblind) <- doypa_colorblind

# Color palettes list
doypa_pals <- list(
  ## Sequential Palettes - n = 9 colors
  blue =           c("#e0ffff", "#c8e3ff", "#afc7ff", "#97abff", "#7e90ff", "#6674ff", "#4d58ff", "#353cff", "#1c20ff"),
  
  deep =           c("#cdf8ff", "#b9dff0", "#a6c5d9", "#93acc2", "#7f92ab", "#6c7994", "#595f7d", "#454666", "#322c4f"),
  
  blue_purple =    c("#cdf8ff", "#c2d1ff", "#b7aaff", "#ad82ff", "#a25bfd", "#874ed3", "#6a43a7", "#4e377b", "#322c4f"),
  
  purple =         c("#ffe1ff", "#ffcaff", "#e9b4ff", "#ca9dfa", "#ac87d7", "#8d70b5", "#6f5993", "#514371", "#322c4f"),
    
  yellow_green =   c("#fefee0", "#aae6a9", "#56cf72", "#02b73b", "#009e1b", "#00831b", "#0c681b", "#1c4e1e", "#003b31"),
  
  doypa_qual =     c("#bceecb", "#91debc", "#67cdac", "#42ba9b", "#7f9d3a", "#d47200", "#d64b02", "#ba2314", "#880024"),
  
  regal_blue =     c("#aaf0e2", "#8fdbd4", "#73c5c6", "#58afb8", "#3c99aa", "#21839c", "#056d8e", "#005780", "#004172"),
  
  blue_red =       c("#9fe5d7", "#65c4d8", "#39a6d5", "#2b8fc7", "#f67d33", "#f44934", "#ca3a43", "#9e0142"),
  
  red =            c("#ffcd7e", "#ffb073", "#ff9269", "#ff755e", "#e85754", "#cd3a49", "#b31c3f", "#990034", "#7e002a"),
  
  orange =         c("#ffe440", "#ffc238", "#ff9f2f", "#ff7d26", "#fe5a1d", "#de3a0b", "#be1900", "#9e0000", "#7e0000"),
  
  pink =           c("#fff0f3", "#ffc7d2", "#ff9fb0", "#ff768f", "#ff4d6d", "#d53d5a", "#ac2d48", "#821d35", "#580d22"),
  
  gray =           c("#f1f0f6", "#d6d4d9", "#bbb8bc", "#9f9c9f", "#848082", "#6f6c6e", "#5b585a", "#464446", "#313033"),
  
  ## Diverging Palettes - n = 11 colors
  blue2red =       c("#232ba7", "#545ab9", "#8b8fce", "#bfc1e1", "#e6e6ef", "#f5f5f5", "#ede2e3", "#d8b0b4", "#bc6d74", "#9e2631", "#840000"),
  
  purple2green =   c("#70257e", "#90579a", "#b48ebb", "#d6c3d9", "#efeaf0", "#f9f9f9", "#e5ede9", "#b3cfbf", "#6fa687", "#277a4c", "#005417"),
  
  mir =            c("#006698", "#2395ad", "#61c4c1", "#96e1d2", "#cce9e5", "#f2ecee", "#ffdba9", "#ffb064", "#ff865b", "#e45355", "#b0214f"),
  
  ## Qualitative Palettes - no limit of colors
  astro =          c("#1D313C", "#F6733A", "#ECD6C3", "#4FA3AB", "#387654"),
  
  buzz =           c("#6036a4", "#9de26b", "#F5C290", "#B1B3B3", "#FF2400", "#ADD8E6"),
  
  cyberpunk =      c("#DFD828", "#61A059", "#085857", "#313638", "#ff2a6d", "#B0BA83"),
  
  earth =          c("#D52429", "#F1602C", "#EC8922", "#915018", "#6C3F18"),
  
  goofy =          c("#F58221", "#00AEEF", "#313638", "#F3D9CE", "#A6CE39"),
  
  google =         c("#4285F4", "#34A853", "#FBBC05", "#EA4335"),
  
  doypa =          c("#2BAF90", "#A1D4B1", "#F1A512", "#DD4111", "#8C0027"),
  
  high_contrast =  c("#00B5B0", "#00FF28", "#FFC700", "#FF0000", "#C70083", "#9500AC"),
  
  nature =         c("#228B22", "#8B4513", "#87CEEB", "#D2B48C", "#84CA67","#BF530D", "#376362"),
  
  retro =          c("#D54751", "#EF9A48", "#FFFCC7", "#4DA394", "#59322B"),
  
  rookie =         c("#ff7f00", "#ff4500", "#836fff", "#00ff7f", "#f9f9f9"),
  
  snack =          c("#0D1282", "#EEEDED", "#F0DE36", "#D71313"),
  
  sunset =         c("#FF4500", "#FF2400", "#FF007F", "#800080"),
  
  tidy =           c("#1C4EAA", "#E36C14", "#666667", "#ADD8E6", "#FBE870"),
  
  vaporwave =      c("#511940", "#F86A2A", "#07B7AD", "#0B60E1", "#E7C6AE")
)
