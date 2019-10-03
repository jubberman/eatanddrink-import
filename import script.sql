SELECT DISTINCT       
			[P_O].[FirstName] AS [firstname],
            [P_O].[LastName] AS [lastname],
            [P_O].ExternalSystemID AS [username],
            CAST(P_RB.[LongRoomNumber] AS NVARCHAR(MAX)) AS [Residence], 
            CAST([Name] AS nvarchar(MAX)) AS [Session]--,--session name
				    
FROM        [Booking].[Booking] B_B
JOIN        [Person].[Occupant] P_O ON P_O.[OccupantID] = B_B.[PersonID]
JOIN        [Business].[BusinessArea] B_BA ON B_BA.[BusinessAreaID] = B_B.[BusinessAreaID]
---LEFT JOIN 	  [Person].[ContactDetails] P_CD ON P_CD.[OccupantID] = B_B.[PersonID]
INNER JOIN    [Booking].[LowLevelBooking] B_LLB ON B_LLB.[LowLevelBookingID] = B_B.[BookingID]
INNER JOIN    [Booking].[LowLevelBookingPeriod] B_LLBP ON B_LLBP.[LowLevelBookingID] = B_LLB.[LowLevelBookingID]
INNER JOIN    [Property].[RoomBed] P_RB ON P_RB.[RoomID] = B_LLB.[RoomID] AND P_RB.[BedID] = B_LLB.[BedID]
INNER JOIN    [Property].[Room] P_R ON P_R.[RoomID] = B_LLB.[RoomID] 
WHERE        B_LLBP.[LowLevelBookingAllocationStateID] != 2  
AND B_LLB.[RoomOutOfServiceID] IS NULL AND ISNULL (B_B.[NoShow], 0) = 0 
and (
P_RB.LongRoomNumber like 'Polden P_.__%' OR -- full £50 account property 7
P_RB.LongRoomNumber like 'Brendon%' OR  -- full £50 account property 7
P_RB.LongRoomNumber like 'Quad%' OR -- part £25 account property 8
P_RB.LongRoomNumber like 'Woodland Court Permanent Shared%'OR  -- part £25 account property 8
P_RB.LongRoomNumber like 'YMCA%'OR -- occasional £70 account property 14
P_RB.LongRoomNumber like 'Conygre Spur%'OR --occasional £50 account property 9
P_RB.LongRoomNumber like 'Cotswold TAcad%' --occasional £50 account property 9
P_RB.LongRoomNumber like 'Eastwood E32%'
)
--and [P_CD].[Email] IS NOT NULL
--and [P_O].ExternalSystemID = 'amm258'

-- Edit this line for current session:
and Name like '19/20 Autumn%'
-- Edit this line for current session:

AND            B_BA.[Summary] = 'Student'
order by Residence asc
