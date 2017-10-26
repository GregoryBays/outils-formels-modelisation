import PetriKit

public class MarkingGraph {

    public let marking   : PTMarking
    public var successors: [PTTransition: MarkingGraph]

    public init(marking: PTMarking, successors: [PTTransition: MarkingGraph] = [:]) {
        self.marking    = marking
        self.successors = successors
    }

}

public extension PTNet {

    public func markingGraph(from marking: PTMarking) -> MarkingGraph? {
        // Write here the implementation of the marking graph generation.

        let transitions = self.transitions

        let initNode = MarkingGraph(marking: marking)

        var needtovisit = [MarkingGraph]()

        var visited = [MarkingGraph]()

        needtovisit.append(initNode)

        while needtovisit.count != 0 {

            let actu = needtovisit.removeFirst()

            visited.append(actu)

            transitions.forEach { trans in

              if let newMark = trans.fire(from: actu.marking) {

                        if let alreadyVisited = visited.first(where: { $0.marking == newMark }) {

                            actu.successors[trans] = alreadyVisited

                        } else {

                            let discovered = MarkingGraph(marking: newMark)

                            actu.successors[trans] = discovered

                            if (!needtovisit.contains(where: { $0.marking == discovered.marking})) {

                                needtovisit.append(discovered)
                            }
                    }
                }
            }
        }

        return initNode
    }


    /*
      Retourne le nombre de nœuds
    */

    public func count (mark: MarkingGraph) -> Int{

      var checked = [MarkingGraph]()

      var tocheck = [MarkingGraph]()

      tocheck.append(mark)

      while let actu = tocheck.popLast() {

        checked.append(actu)

        for(_, successor) in actu.successors{

          if !checked.contains(where: {$0 === successor}) && !tocheck.contains(where: {$0 === successor}){

              tocheck.append(successor)
            }
          }
      }
      return checked.count
    }

    /*
      retourne true si il y a deux fumeurs
    */

    public func moresmokers (mark: MarkingGraph) -> Bool {

      var checked = [MarkingGraph]()

      var tocheck = [MarkingGraph]()

      tocheck.append(mark)

      while let actu = tocheck.popLast() {

        checked.append(actu)

        var nbSmoke = 0;

        for (key, value) in actu.marking {

            if (key.name == "s1" || key.name == "s2" || key.name == "s3"){

               nbSmoke += Int(value)
            }
        }
        if (nbSmoke > 1) {

          return true
        }
        for(_, successor) in actu.successors{

          if !checked.contains(where: {$0 === successor}) && !tocheck.contains(where: {$0 === successor}){

              tocheck.append(successor)
            }
          }
      }
      return false
    }
    /*
      Check les ingrédients sur la table
    */

    public func twosame (mark: MarkingGraph) -> Bool {

      var checked = [MarkingGraph]()

      var tocheck = [MarkingGraph]()

      tocheck.append(mark)

      while let actu = tocheck.popLast() {

        checked.append(actu)

        for (key, value) in actu.marking {

            if (key.name == "p" || key.name == "t" || key.name == "m"){

               if(value > 1){

                 return true
               }
            }
        }
        for(_, successor) in actu.successors{

          if !checked.contains(where: {$0 === successor}) && !tocheck.contains(where: {$0 === successor}){

              tocheck.append(successor)
            }
          }
      }
      return false
    }

}
