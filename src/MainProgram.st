USING Siemens.Simatic.S71500.Clocks;

CLASS Valve
    {S7.extern=ReadOnly}
    VAR PUBLIC
        {S7.extern=Read}
        rFlowRate_Current:REAL;
        rFlowRate_Max:REAL := 1;
        {S7.extern=ReadWrite}
        cOpenPercent:Byte;
        {S7.extern=Read}
        bIsOpen:Bool;
        name: string;        
    END_VAR
END_CLASS

CLASS OutputValve EXTENDS Valve
    VAR PUBLIC
        {S7.extern=ReadWrite}
        isEmergencyDraining:Bool;
    END_VAR
END_CLASS

TYPE
    {S7.extern=ReadOnly}
    Tank: STRUCT
        {S7.extern=ReadWrite}
        inputValve: Valve;
        {S7.extern=ReadWrite}
        outputValve: OutputValve;
        rFillRate:REAL;
        rVolume_Max:REAL := 300;
        rVolume_Current:REAL;
        cVolume_Percent:BYTE;
        bIsOverflow:BOOL;
        strCurrentStatus:STRING;
        ldtLastOverflow:LDATE_AND_TIME;
    END_STRUCT;
END_TYPE

PROGRAM WaterTank
    VAR_EXTERNAL
        tank: Tank;
    END_VAR

    VAR

    END_VAR

    VAR_TEMP
        temp:REAL;
    END_VAR
 ;
    //Set input params
    IF tank.inputValve.cOpenPercent <> BYTE#0 THEN
        tank.inputValve.bIsOpen := true;
        tank.inputValve.rFlowRate_Current := tank.inputValve.rFlowRate_Max * TO_INT(tank.inputValve.cOpenPercent) / 100;
    ELSE
        tank.inputValve.bIsOpen := false;
        tank.inputValve.rFlowRate_Current := 0;
    END_IF;

    // Set output params

    IF tank.outputValve.isEmergencyDraining THEN
        tank.outputValve.bIsOpen := true;
        tank.outputValve.cOpenPercent := BYTE#100;
        tank.outputValve.rFlowRate_Current := tank.outputValve.rFlowRate_Max * TO_INT(tank.outputValve.cOpenPercent) / 100;
    ELSIF tank.outputValve.cOpenPercent <> BYTE#0 THEN
        tank.outputValve.bIsOpen := true;
        tank.outputValve.rFlowRate_Current := tank.outputValve.rFlowRate_Max * TO_INT(tank.outputValve.cOpenPercent) / 100;
    ELSE
        tank.outputValve.bIsOpen := false;
        tank.outputValve.rFlowRate_Current := 0;
    END_IF;

    // Calculate fill rate
    tank.rFillRate := tank.inputValve.rFlowRate_Current - tank.outputValve.rFlowRate_Current;

    // Set status based on fill rate
    IF tank.rFillRate < 0 THEN
        tank.strCurrentStatus := 'Emptying';
    ELSIF tank.rFillRate > 0 THEN
        tank.strCurrentStatus := 'Filling';
    ELSE
        tank.strCurrentStatus := 'Sustaining';
    END_IF;

    // Adjust tank values
    temp := tank.rVolume_Current + tank.rFillRate;
    if temp > tank.rVolume_Max THEN
        temp := tank.rVolume_Max;
    ELSIF temp < 0 THEN
        temp := 0;
    END_IF;

    IF temp <= 0 THEN
        tank.rVolume_Current := 0;
        tank.bIsOverflow := false;
    ELSIF temp >= tank.rVolume_Max THEN
        tank.rVolume_Current := tank.rVolume_Max;
        tank.bIsOverflow := true;
        GetSystemDateTime(value => tank.ldtLastOverflow);
        tank.strCurrentStatus := 'Overflowing';
    ELSE
        tank.rVolume_Current := temp;
        tank.bIsOverflow := false;
    END_IF;

    // Calculate percentage of tank filled
    temp := tank.rVolume_Current / tank.rVolume_Max * 100;
    tank.cVolume_Percent := TO_BYTE(TO_INT(temp));

    IF tank.rVolume_Current = 0 THEN
        tank.outputValve.isEmergencyDraining := false;
    END_IF;
END_PROGRAM
