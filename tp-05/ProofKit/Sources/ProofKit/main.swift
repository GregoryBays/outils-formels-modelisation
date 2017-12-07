import ProofKitLib

let a: Formula = "a"
let b: Formula = "b"
let c: Formula = "c"
let f = !(a && (b || c))
let g = ( a => b ) || !(a && c)
let h = (!a || b && c) && a
print("1.")
print(f.nnf)
print("2.")
print(g.nnf)
print("3.")
print(h.nnf)
print("--------TP TEST--------")
print("---------1.--------")
print("cnf :")
print(f.cnf)
print("dnf :")
print(f.dnf)
print("---------2.--------")
print("cnf :")
print(g.cnf)
print("dnf :")
print(g.dnf)
print("---------3.--------")
print("cnf :")
print(h.cnf)
print("dnf :")
print(h.dnf)
print("--------TEST FIN--------")
// cnf ex1 (!a || !b) && (!a || !c) dnf  = nnf
// cnf ex2 (!a || b || !c ) = dnf
// cnf ex3 (photo)

let booleanEvaluation = f.eval { (proposition) -> Bool in
    switch proposition {
        case "p": return true
        case "q": return false
        default : return false
    }
}
print(booleanEvaluation)

enum Fruit: BooleanAlgebra {

    case apple, orange

    static prefix func !(operand: Fruit) -> Fruit {
        switch operand {
        case .apple : return .orange
        case .orange: return .apple
        }
    }

    static func ||(lhs: Fruit, rhs: @autoclosure () throws -> Fruit) rethrows -> Fruit {
        switch (lhs, try rhs()) {
        case (.orange, .orange): return .orange
        case (_ , _)           : return .apple
        }
    }

    static func &&(lhs: Fruit, rhs: @autoclosure () throws -> Fruit) rethrows -> Fruit {
        switch (lhs, try rhs()) {
        case (.apple , .apple): return .apple
        case (_, _)           : return .orange
        }
    }

}

let fruityEvaluation = f.eval { (proposition) -> Fruit in
    switch proposition {
        case "p": return .apple
        case "q": return .orange
        default : return .orange
    }
}
print(fruityEvaluation)
