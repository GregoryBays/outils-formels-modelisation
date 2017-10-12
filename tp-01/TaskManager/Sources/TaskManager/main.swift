import TaskManagerLib


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

let m21 = create2.fire(from: [taskPool2: 0, processPool2: 0, inProgress2: 0, buffer: 0])
print("m1 (create) ",m21!)
let m22 = spawn2.fire(from: m21!)
print("m2 (spawn) ",m22!)
let m23 = spawn2.fire(from: m22!)
print("m3 (spawn)",m23!)
let m24 = exec2.fire(from: m23!)
print("m4 (exec) ",m24!)
let m25 = success2.fire(from: m24!)
print("m5 (success) ",m25!)
let m27 = fail2.fire(from: m24!)
print("m5 (fail) ",m27!)
