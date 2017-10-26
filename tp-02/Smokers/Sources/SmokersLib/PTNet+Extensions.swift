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

        let m0:MarkingGraph = MarkingGraph(marking: marking)

        var NodeVisited:[MarkingGraph] = [m0]

        var ToVisit:[MarkingGraph] = [m0]

        while let actu = ToVisit.popLast(){

          NodeVisited.append(actu)

          for tran in transitions{

            if let firedTran = tran.fire(from: actu.marking){

              if let visited = NodeVisited.first(where: {$0.marking == firedTran}){

                actu.successors[tran] = visited

              } else{

                let temp:MarkingGraph = MarkingGraph(marking: firedTran)

                if !NodeVisited.contains{$0 === temp}{

                  actu.successors[tran] = temp

                  ToVisit.append(temp)
                }
              }
            }
          }
        }

        print("\(NodeVisited)")

        return m0
    }

}
