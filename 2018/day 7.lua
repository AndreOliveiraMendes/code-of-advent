input = [[Step Z must be finished before step B can begin.
Step X must be finished before step D can begin.
Step D must be finished before step P can begin.
Step O must be finished before step C can begin.
Step C must be finished before step Y can begin.
Step K must be finished before step J can begin.
Step H must be finished before step T can begin.
Step B must be finished before step Q can begin.
Step V must be finished before step M can begin.
Step E must be finished before step W can begin.
Step S must be finished before step J can begin.
Step I must be finished before step N can begin.
Step T must be finished before step L can begin.
Step N must be finished before step M can begin.
Step P must be finished before step G can begin.
Step F must be finished before step Q can begin.
Step J must be finished before step G can begin.
Step L must be finished before step G can begin.
Step Y must be finished before step R can begin.
Step U must be finished before step A can begin.
Step W must be finished before step G can begin.
Step R must be finished before step G can begin.
Step G must be finished before step M can begin.
Step A must be finished before step Q can begin.
Step M must be finished before step Q can begin.
Step N must be finished before step F can begin.
Step Y must be finished before step W can begin.
Step J must be finished before step W can begin.
Step U must be finished before step G can begin.
Step X must be finished before step L can begin.
Step P must be finished before step J can begin.
Step L must be finished before step Y can begin.
Step G must be finished before step Q can begin.
Step K must be finished before step G can begin.
Step V must be finished before step J can begin.
Step F must be finished before step U can begin.
Step V must be finished before step N can begin.
Step I must be finished before step T can begin.
Step U must be finished before step W can begin.
Step S must be finished before step A can begin.
Step C must be finished before step G can begin.
Step L must be finished before step A can begin.
Step E must be finished before step L can begin.
Step D must be finished before step H can begin.
Step Z must be finished before step E can begin.
Step J must be finished before step U can begin.
Step R must be finished before step A can begin.
Step C must be finished before step J can begin.
Step T must be finished before step R can begin.
Step Z must be finished before step D can begin.
Step Y must be finished before step G can begin.
Step Y must be finished before step M can begin.
Step X must be finished before step H can begin.
Step S must be finished before step Q can begin.
Step R must be finished before step Q can begin.
Step D must be finished before step Q can begin.
Step G must be finished before step A can begin.
Step N must be finished before step A can begin.
Step F must be finished before step L can begin.
Step O must be finished before step N can begin.
Step T must be finished before step J can begin.
Step S must be finished before step T can begin.
Step O must be finished before step M can begin.
Step P must be finished before step Y can begin.
Step I must be finished before step U can begin.
Step V must be finished before step S can begin.
Step F must be finished before step G can begin.
Step P must be finished before step M can begin.
Step C must be finished before step S can begin.
Step A must be finished before step M can begin.
Step C must be finished before step Q can begin.
Step Y must be finished before step Q can begin.
Step O must be finished before step P can begin.
Step S must be finished before step R can begin.
Step S must be finished before step Y can begin.
Step I must be finished before step Q can begin.
Step O must be finished before step T can begin.
Step F must be finished before step W can begin.
Step U must be finished before step R can begin.
Step O must be finished before step U can begin.
Step D must be finished before step L can begin.
Step H must be finished before step I can begin.
Step P must be finished before step R can begin.
Step J must be finished before step L can begin.
Step P must be finished before step W can begin.
Step W must be finished before step Q can begin.
Step X must be finished before step Q can begin.
Step Z must be finished before step U can begin.
Step T must be finished before step U can begin.
Step D must be finished before step S can begin.
Step U must be finished before step Q can begin.
Step N must be finished before step G can begin.
Step E must be finished before step Q can begin.
Step X must be finished before step K can begin.
Step J must be finished before step R can begin.
Step X must be finished before step R can begin.
Step T must be finished before step W can begin.
Step K must be finished before step S can begin.
Step S must be finished before step G can begin.
Step P must be finished before step F can begin.
Step X must be finished before step C can begin.]]
list = {}
req = {}
dlist = {}
function insert(list, s)
	local list2 = {table.unpack(list)}
	table.sort(list2)
	local st, en = 1, #list2
	local ach = false
	while (st <= en) and not ach do
		local midle = (st + en)//2
		if list2[midle] > s then
			en = midle - 1
		elseif list2[midle] < s then
			st = midle + 1
		else
			ach = true
		end
	end
	if not ach then
		table.insert(list, s)
	end
end
for word in input:gmatch("%C+") do
    local s1 = word:match("Step %a"):sub(-1)
    local s2 = word:match("step %a"):sub(-1)
    insert(list, s1)
	insert(list, s2)
	dlist[s1] = false
	dlist[s2] = false
	if not req[s2] then req[s2] = {} end
	insert(req[s2], s1)
end
str = ""
function check(l1, l2)
	for _, l in pairs(l1) do
		if not l2[l] then return true end
	end
	return false
end
table.sort(list)
function solve(l1, l2, l3)
	for _,l in ipairs(l1) do
		if not l2[l] and (not l3[l] or not check(l3[l], l2)) then
			l2[l] = true
			return l
		end
	end
	return ""
end
while check(list, dlist) do
	local l = solve(list, dlist, req)
	str = str .. l
end
--step 1
print("answer 1:" .. str)
--step 2
tlist = {}
for i in pairs(dlist) do
    dlist[i] = false
    tlist[i] = false
end
local t = 0
w1, w2, w3, w4, w5 = {}, {}, {}, {}, {}
team = {w1, w2, w3, w4, w5}
for _, w in ipairs(team) do
    w.q = {}
    w.t = 0
end
function value(l)
    return l:byte() - string.byte("A") + 1 + 60
end
function solve2(l1, l2, l3, l4, w)
    --solve pendents queues
    if #w.q ~= 0 then
        local l = w.q[1]
        w.t = w.t + 1
        if w.t == value(l) then
            l2[l] = true
            table.remove(w.q, 1)
            w.t = 0
        end
    end
    --do more queues if possible
    if #w.q == 0 then
        for _, l in ipairs(l1) do
            if not l2[l] and not l3[l] and (not l4[l] or not check(l4[l], l2)) then
                l3[l] = true
                table.insert(w.q, l)
                break
            end
        end
    end
end
while true do
    --solve
    for _, w in ipairs(team) do
        solve2(list, dlist, tlist, req, w)
    end
    --break if done
    if not check(list, dlist) then
        break
    end
    t = t + 1
end
print("answer 2:" .. t - 1)
