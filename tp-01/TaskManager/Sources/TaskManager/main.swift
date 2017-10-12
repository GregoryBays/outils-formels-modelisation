import TaskManagerLib

//Grégory Bays
// Exercice 3
print("Exercice 3")
let taskManager = createTaskManager()
let create = taskManager.transitions.first{$0.name == "create"}!
let spawn = taskManager.transitions.first{$0.name == "spawn"}!
let exec = taskManager.transitions.first{$0.name == "exec"}!
let success = taskManager.transitions.first{$0.name == "success"}!
let fail = taskManager.transitions.first{$0.name == "fail"}!
let taskPool = taskManager.places.first{$0.name == "taskPool"}!
let processPool = taskManager.places.first{$0.name == "processPool"}!
let inProgress = taskManager.places.first{$0.name == "inProgress"}!

let m1 = create.fire(from: [taskPool: 0, processPool: 0, inProgress: 0])
print("m1 (create) ",m1!)
let m2 = spawn.fire(from: m1!)
print("m2 (spawn) ",m2!)
let m3 = spawn.fire(from: m2!)
print("m3 (spawn)",m3!)
let m4 = exec.fire(from: m3!)
print("m4 (exec) ",m4!)
let m5 = exec.fire(from: m4!)
print("m5 (exec)",m5!)
let m6 = success.fire(from: m5!)
print("m6 (success) ",m6!)
//Il reste un Token dans processpool que l'on ne peut pas enlever malgrés que l'exécution ai été un succès

//Exercice 4
print("Exercice 4: Correct TaskManager")
let correctTaskManager = createCorrectTaskManager()
let create2 = correctTaskManager.transitions.first{$0.name == "create"}!
let spawn2 = correctTaskManager.transitions.first{$0.name == "spawn"}!
let exec2 = correctTaskManager.transitions.first{$0.name == "exec"}!
let success2 = correctTaskManager.transitions.first{$0.name == "success"}!
let fail2 = correctTaskManager.transitions.first{$0.name == "fail"}!
let taskPool2 = correctTaskManager.places.first{$0.name == "taskPool"}!
let processPool2 = correctTaskManager.places.first{$0.name == "processPool"}!
let inProgress2 = correctTaskManager.places.first{$0.name == "inProgress"}!
let buffer = correctTaskManager.places.first{$0.name == "buffer"}!

let m11 = create2.fire(from: [taskPool2: 0, processPool2: 0, inProgress2: 0, buffer: 0])
print("m1 (create) ",m11!)
let m12 = spawn2.fire(from: m11!)
print("m2 (spawn) ",m12!)
let m13 = spawn2.fire(from: m12!)
print("m3 (spawn)",m13!)
let m14 = exec2.fire(from: m13!)
print("m4 (exec) ",m14!)
let m15 = success2.fire(from: m14!)
print("m5 (success) ",m15!)
//on relance un fail depuis m14
let m16 = fail2.fire(from: m14!)
print("m5 (fail) ",m16!)
