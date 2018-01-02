--https://stackoverflow.com/questions/5249629/modifying-a-character-in-a-string-in-lua
function replace_char(pos1, pos2, str, r)
    return str:sub(1, pos1-1) .. r .. str:sub(pos2+1)
end
input = [[Al => ThF
Al => ThRnFAr
B => BCa
B => TiB
B => TiRnFAr
Ca => CaCa
Ca => PB
Ca => PRnFAr
Ca => SiRnFYFAr
Ca => SiRnMgAr
Ca => SiTh
F => CaF
F => PMg
F => SiAl
H => CRnAlAr
H => CRnFYFYFAr
H => CRnFYMgAr
H => CRnMgYFAr
H => HCa
H => NRnFYFAr
H => NRnMgAr
H => NTh
H => OB
H => ORnFAr
Mg => BF
Mg => TiMg
N => CRnFAr
N => HSi
O => CRnFYFAr
O => CRnMgAr
O => HP
O => NRnFAr
O => OTi
P => CaP
P => PTi
P => SiRnFAr
Si => CaSi
Th => ThCa
Ti => BP
Ti => TiTi
e => HF
e => NAl
e => OMg]]
input_element = "CRnCaSiRnBSiRnFArTiBPTiTiBFArPBCaSiThSiRnTiBPBPMgArCaSiRnTiMgArCaSiThCaSiRnFArRnSiRnFArTiTiBFArCaCaSiRnSiThCaCaSiRnMgArFYSiRnFYCaFArSiThCaSiThPBPTiMgArCaPRnSiAlArPBCaCaSiRnFYSiThCaRnFArArCaCaSiRnPBSiRnFArMgYCaCaCaCaSiThCaCaSiAlArCaCaSiRnPBSiAlArBCaCaCaCaSiThCaPBSiThPBPBCaSiRnFYFArSiThCaSiRnFArBCaCaSiRnFYFArSiThCaPBSiThCaSiRnPMgArRnFArPTiBCaPRnFArCaCaCaCaSiRnCaCaSiRnFYFArFArBCaSiThFArThSiThSiRnTiRnPMgArFArCaSiThCaPBCaSiRnBFArCaCaPRnCaCaPMgArSiRnFYFArCaSiThRnPBPMgAr"
function tinsertr(t, value)
    local chk = true
    for i, s in pairs(t) do
        if s == value then
            chk = false
            break
        end
    end
    if chk then table.insert(t, value) end
end
temp = {}
for word in string.gmatch(input, "%a+") do
    table.insert(temp, word)
end
elemental_replace = {}
elements = {}
for i = 1, #temp, 2 do
    tinsertr(elements, temp[i])
    table.insert(elemental_replace, {temp[i], temp[i + 1]})
end
temp = nil
distincts_mol = {}
for i, s in pairs(elemental_replace) do
    local s_in, s_out = s[1], s[2]
    local i, o = input_element:find(s_in)
    while i do
        local mol = replace_char(i, o, input_element, s_out)
        tinsertr(distincts_mol, mol)
        i, o = input_element:find(s_in, o + 1)
    end
end
--part I
print("there are " .. #distincts_mol .. " distincts molecules possible")
