# operator pending remaps: ie ciw: change in word
{ ... }: let modes = ["o" "v"]; in [
    { mode = modes; key = "hs"; action = "i["; }
    { mode = modes; key = "ks"; action = "a["; }

    { mode = modes; key = "hd"; action = "i\""; }
    { mode = modes; key = "kd"; action = "a\""; }

    { mode = modes; key = "hq"; action = "i'"; }
    { mode = modes; key = "kq"; action = "a'"; }
]
