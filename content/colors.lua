-- standard HTML color codes from https://htmlcolorcodes.com/color-names/, accessed 20211115
local colors = {
    {"IndianRed", Color(205, 92, 92)},
    {"LightCoral", Color(240, 128, 128)},
    {"Salmon", Color(250, 128, 114)},
    {"DarkSalmon", Color(233, 150, 122)},
    {"LightSalmon", Color(255, 160, 122)},
    {"Crimson", Color(220, 20, 60)},
    {"Red", Color(255, 0, 0)},
    {"FireBrick", Color(178, 34, 34)},
    {"DarkRed", Color(139, 0, 0)},
    {"Pink", Color(255, 192, 203)},
    {"LightPink", Color(255, 182, 193)},
    {"HotPink", Color(255, 105, 180)},
    {"DeepPink", Color(255, 20, 247)},
    {"MediumVioletRed", Color(199, 21, 133)},
    {"PaleVioletRed", Color(219, 112, 147)},
    {"LightSalmon", Color(255, 160, 122)},
    {"Coral", Color(255, 127, 80)},
    {"Tomato", Color(255, 99, 71)},
    {"OrangeRed", Color(255, 69, 0)},
    {"DarkOrange", Color(255, 140, 0)},
    {"Orange", Color(255, 165, 0)},
    {"Gold", Color(255, 215, 0)},
    {"Yellow", Color(255, 255, 0)},
    {"LightYellow", Color(255, 255, 224)},
    {"LemonChiffon", Color(255, 250, 205)},
    {"LightGoldenrodYellow", Color(250, 250, 10)},
    {"PapayaWhip", Color(255, 239, 213)},
    {"Moccasin", Color(255, 228, 181)},
    {"PeachPuff", Color(255, 218, 185)},
    {"PaleGoldenrod", Color(238, 232, 170)},
    {"Khaki", Color(240, 230, 140)},
    {"DarkKhaki", Color(189, 183, 107)},
    {"Lavender", Color(230, 230, 250)},
    {"Thistle", Color(216, 191, 216)},
    {"Plum", Color(221, 160, 221)},
    {"Violet", Color(238, 130, 238)},
    {"Orchid", Color(218, 112, 214)},
    {"Fuchsia", Color(255, 0, 255)},
    {"Magenta", Color(255, 0, 255)},
    {"MediumOrchid", Color(186, 85, 211)},
    {"MediumPurple", Color(147, 112, 219)},
    {"RebeccaPurple", Color(102, 51, 153)},
    {"BlueViolet", Color(138, 43, 226)},
    {"DarkViolet", Color(148, 0, 211)},
    {"DarkOrchid", Color(153, 50, 204)},
    {"DarkMagenta", Color(139, 0, 139)},
    {"Purple", Color(128, 0, 128)},
    {"Indigo", Color(75, 0, 130)},
    {"SlateBlue", Color(106, 90, 205)},
    {"DarkSlateBlue", Color(72, 61, 139)},
    {"MediumSlateBlue", Color(123, 104, 238)},
    {"GreenYellow", Color(173, 255, 47)},
    {"Chartreuse", Color(127, 255, 0)},
    {"LawnGreen", Color(124, 252, 0)},
    {"Lime", Color(0, 255, 0)},
    {"LimeGreen", Color(50, 205, 50)},
    {"PaleGreen", Color(152, 251, 152)},
    {"LightGreen", Color(144, 238, 144)},
    {"MediumSpringGreen", Color(0, 250, 154)},
    {"SpringGreen", Color(0, 255, 127)},
    {"MediumSeaGreen", Color(60, 179, 113)},
    {"SeaGreen", Color(46, 139, 87)},
    {"ForestGreen", Color(34, 139, 34)},
    {"Green", Color(0, 128, 0)},
    {"DarkGreen", Color(0, 100, 0)},
    {"YellowGreen", Color(154, 205, 50)},
    {"OliveDrab", Color(107, 142, 35)},
    {"Olive", Color(128, 128, 0)},
    {"DarkOliveGreen", Color(85, 107, 47)},
    {"MediumAquamarine", Color(102, 205, 170)},
    {"DarkSeaGreen", Color(143, 188, 139)},
    {"LightSeaGreen", Color(32, 178, 170)},
    {"DarkCyan", Color(0, 139, 139)},
    {"Teal", Color(0, 128, 128)},
    {"Aqua", Color(0, 255, 255)},
    {"Cyan", Color(0, 255, 255)},
    {"LightCyan", Color(224, 255, 255)},
    {"PaleTurquoise", Color(175, 238, 238)},
    {"Aquamarine", Color(127, 255, 212)},
    {"Turquoise", Color(64, 224, 208)},
    {"MediumTurquoise", Color(72, 209, 204)},
    {"DarkTurquoise", Color(0, 206, 209)},
    {"CadetBlue", Color(95, 158, 160)},
    {"SteelBlue", Color(70, 130, 180)},
    {"LightSteelBlue", Color(176, 196, 222)},
    {"PowderBlue", Color(176, 224, 230)},
    {"LightBlue", Color(173, 216, 230)},
    {"SkyBlue", Color(135, 206, 235)},
    {"LightSkyBlue", Color(135, 206, 250)},
    {"DeepSkyBlue", Color(0, 191, 255)},
    {"DodgerBlue", Color(30, 144, 255)},
    {"CornflowerBlue", Color(100, 149, 237)},
    {"MediumSlateBlue", Color(123, 104, 238)},
    {"RoyalBlue", Color(65, 105, 225)},
    {"Blue", Color(0, 0, 255)},
    {"MediumBlue", Color(0, 0, 205)},
    {"DarkBlue", Color(0, 0, 139)},
    {"Navy", Color(0, 0, 128)},
    {"MidnightBlue", Color(25, 25, 112)},
    {"Cornsilk", Color(255, 248, 220)},
    {"BlanchedAlmond", Color(255, 235, 205)},
    {"Bisque", Color(255, 228, 196)},
    {"NavajoWhite", Color(255, 222, 173)},
    {"Wheat", Color(245, 222, 179)},
    {"BurlyWood", Color(222, 184, 135)},
    {"Tan", Color(210, 180, 140)},
    {"RosyBrown", Color(188, 143, 143)},
    {"SandyBrown", Color(244, 164, 96)},
    {"Goldenrod", Color(218, 165, 32)},
    {"DarkGoldenrod", Color(184, 134, 11)},
    {"Peru", Color(205, 133, 63)},
    {"Chocolate", Color(210, 105, 30)},
    {"SaddleBrown", Color(139, 69, 19)},
    {"Sienna", Color(160, 82, 45)},
    {"Brown", Color(165, 42, 42)},
    {"Maroon", Color(128, 0, 0)},
    {"White", Color(255, 255, 255)},
    {"Snow", Color(255, 250, 250)},
    {"HoneyDew", Color(240, 255, 240)},
    {"MintCream", Color(245, 255, 250)},
    {"Azure", Color(240, 255, 255)},
    {"AliceBlue", Color(240, 248, 255)},
    {"GhostWhite", Color(248, 248, 255)},
    {"WhiteSmoke", Color(245, 245, 245)},
    {"SeaShell", Color(255, 245, 238)},
    {"Beige", Color(245, 245, 220)},
    {"OldLace", Color(253, 245, 230)},
    {"FloralWhite", Color(255, 250, 240)},
    {"Ivory", Color(255, 255, 240)},
    {"AntiqueWhite", Color(250, 235, 215)},
    {"Linen", Color(250, 240, 230)},
    {"LavenderBlush", Color(255, 240, 245)},
    {"MistyRose", Color(255, 228, 225)},
    {"Gainsboro", Color(220, 220, 200)},
    {"LightGray", Color(211, 211, 211)},
    {"Silver", Color(192, 192, 192)},
    {"DarkGray", Color(169, 169, 169)},
    {"Gray", Color(128, 128, 128)},
    {"DimGray", Color(105, 105, 105)},
    {"LightSlateGray", Color(119, 136, 153)},
    {"SlateGray", Color(112, 128, 144)},
    {"DarkSlateGray", Color(47, 79, 79)},
    {"Black", Color(0, 0, 0)}
}

function GetRandomColor()
    return colors[math.random(#colors)]
end