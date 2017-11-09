import PetriKit

public extension PTNet {
    
    public func coverabilityToPTMarking(with marking : CoverabilityMarking, and p : [PTPlace]) -> PTMarking{
      var m : PTMarking = [:]

      for temp in p
      {
        let this = correctValue(to : marking[temp]!)!
        m[temp] = this
      }
      return m
    }


    public func ptmarkingToCoverability(with marking: PTMarking, and p : [PTPlace]) ->CoverabilityMarking{
      var temp : CoverabilityMarking = [:]
      for val in p
      {
        temp[val] = .some(marking[val]!)
        if(500 < temp[val]!)
        {
          temp[val] = .omega
        }
      }
      return temp
    }


    public func correctValue(to t: Token) -> UInt? {
      if case .some(let value) = t {
        return value
      }
      else {
        return 1000
      }
    }

    //véfifie les noeuds

    public func verify(at marking : [CoverabilityMarking], to markingToAdd : CoverabilityMarking) -> Int
    {
      var value = 0
      for i in 0...marking.count-1

      {
        if (marking[i] == markingToAdd)

        {
          value = 1
        }
        if (markingToAdd > marking[i])

        {
          value = i+2}
      }
      return value
    }

    // ajoute omega

    public func Omega(from comp : CoverabilityMarking, with marking : CoverabilityMarking, and p : [PTPlace])  -> CoverabilityMarking?
    {
      var temp = marking
      for t in p
      {
        if (comp[t]! < temp[t]!)
        {
          temp[t] = .omega
        }
      }
      return temp
    }

    public func coverabilityGraph(from marking0: CoverabilityMarking) -> CoverabilityGraph? {

        var transitionsC = Array (transitions) // sort les valeurs de l'array
        transitionsC.sort{$0.name < $1.name}
        let placesC = Array(places)

        var markingList : [CoverabilityMarking] = [marking0]
        var graphList : [CoverabilityGraph] = []
        var this: CoverabilityMarking
        let returnedGraph = CoverabilityGraph(marking: marking0, successors: [:])
        var count = 0

        while(count < markingList.count)
        {
        for tran in transitionsC
        {
            let ptMarking = coverabilityToPTMarking(with: markingList[count], and: placesC)
            if let firedTran = tran.fire(from: ptMarking){

              let convMarking = ptmarkingToCoverability(with: firedTran, and: placesC)

              let newCouv = CoverabilityGraph(marking: convMarking, successors: [:])

              returnedGraph.successors[tran] = newCouv
            }

            if(returnedGraph.successors[tran] != nil){

              this = returnedGraph.successors[tran]!.marking

              let cur = verify(at: markingList, to: this)

              if (cur != 1)
              {
                if (cur > 1)
                {
                  this = Omega(from : markingList[cur-2], with : this, and : placesC)!
                }

                graphList.append(returnedGraph)

                markingList.append(this)
              }
            }
          }
          count = count + 1
        }
        return returnedGraph
      }
}
