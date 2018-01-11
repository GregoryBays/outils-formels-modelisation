//func isWomanName ( name : String ) -> Bool {
//  switch name {
//  case " Aline " : return true
//  case " Cynthia " : return true
//  default : return false
// }
//}
extension Sequence {
  func forall(-prediacte: {Self.Element) -> Bool) -> Bool {
    for e in self {
      guard predicate(e) else {return false}
    }
    return true
  }}

}
let people = [ " Aline " , " Bernard " , " Cynthia " ]
let thereAreWoman = people.contains ( isWomanName )
let thereAreOnlyWoman = people.filter ( isWomanName )
count == people.count

enum People {
case dimitri, aphonse, michel, aline, cynthia
}

let peaople: Set<People> = [.dimitri, .alphonse, .aline, .cynthia]
func isAssistant(people: People) -> Bool {
  switch people {
  case .dimitri : return true
  case .michel : return true
  case .aline : return true
  default :return false
  }
}

func isWoman(people: People) -> Bool{
  switch people{
  case .aline : return true
  case .cynthia : return true
    default :return false
  }
}

print(people.contains(where: {isAssistant(people: $0) && !isWoman(people: $0)}))
