//Change to SymbolName and use the SymbolName TIA project for proper mappings with string nodeIds
{OpcUa.NodeGenerator.IdType = AutoIncrement}
CONFIGURATION MyConfiguration
    TASK Main(Interval := T#50ms, Priority := 1);
    PROGRAM P1 WITH Main: WaterTank;

    VAR_GLOBAL
        {OpcUa.accesslevel=ReadWrite}
        {S7.extern=ReadWrite}
        tank: Tank;
    END_VAR
END_CONFIGURATION
