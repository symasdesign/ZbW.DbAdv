using System;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;
using System.Collections.Generic;

/*
 * IsInvariantToDuplicates:
 * Used by the query processor, this property is true if the aggregate is invariant to duplicates. 
 * That is, the aggregate of S, {X} is the same as aggregate of S when X is already in S. 
 * For example, aggregate functions such as MIN and MAX satisfy this property, while SUM does not.
 * 
 * analog für die weiteren IsInvariantTo...-Optionen
 */

[Serializable]
[Microsoft.SqlServer.Server.SqlUserDefinedAggregate(
    Format.UserDefined,
    IsInvariantToDuplicates = false,
    IsInvariantToNulls = false,
    IsInvariantToOrder = false,
    MaxByteSize = 8000
)]
public struct Median : IBinarySerialize {
    private List<SqlInt32> numList;
    private SqlInt32 median;


    public void Init() {
        numList = new List<SqlInt32>();
    }

    public void Accumulate(SqlInt32 value) {
        numList.Add(value);
    }

    public void Merge(Median group) {
        this.numList.AddRange(group.numList.ToArray());

    }

    public SqlInt32 Terminate() {
        numList.Sort();
        var med = numList.Count / 2;

        if (numList.Count % 2 == 1) {
            median = numList[med];
        } else {
            median = (numList[med] + numList[med - 1]) / 2;
        }
        return median;
    }

    public void Read(System.IO.BinaryReader r) {
        var x = r.ReadInt32();
        this.numList = new List<SqlInt32>(x);
        for (var i = 0; i < x; i++) {
            this.numList.Add(r.ReadInt32());
        }
    }

    public void Write(System.IO.BinaryWriter w) {
        w.Write(this.numList.Count);
        foreach (int i in this.numList) {
            w.Write(i);
        }
    }
}