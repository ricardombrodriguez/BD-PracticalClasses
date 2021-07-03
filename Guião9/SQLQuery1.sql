!-- 1)

DBCC FREEPROCCACHE;
DBCC DROPCLEANBUFFERS;
GO
select * from
Production.WorkOrder

!-- 2)

DBCC FREEPROCCACHE;
DBCC DROPCLEANBUFFERS;
GO
select * from Production.WorkOrder where WorkOrderID=1234

!-- 3)

DBCC FREEPROCCACHE;
DBCC DROPCLEANBUFFERS;
GO
SELECT * FROM Production.WorkOrder
WHERE WorkOrderID between 10000 and 10010
SELECT * FROM Production.WorkOrder
WHERE WorkOrderID between 1 and 72591

!-- 4)

DBCC FREEPROCCACHE;
DBCC DROPCLEANBUFFERS;
GO
SELECT * FROM Production.WorkOrder
WHERE StartDate = '2007-06-25'

!-- 5)

DBCC FREEPROCCACHE;
DBCC DROPCLEANBUFFERS;
GO
SELECT * FROM Production.WorkOrder WHERE ProductID = 757

!-- 6)

CREATE NONCLUSTERED INDEX [IX_ProductID_covered_StartDate] ON [Production].[WorkOrder]
(
    [ProductID] ASC
)
INCLUDE([StartDate]);

DBCC FREEPROCCACHE;
DBCC DROPCLEANBUFFERS;
GO
SELECT WorkOrderID, StartDate FROM Production.WorkOrder
WHERE ProductID = 757
SELECT WorkOrderID, StartDate FROM Production.WorkOrder
WHERE ProductID = 945
SELECT WorkOrderID FROM Production.WorkOrder
WHERE ProductID = 945 AND StartDate = '2006-01-04'!-- 7)DBCC FREEPROCCACHE;
DBCC DROPCLEANBUFFERS;
GOSELECT WorkOrderID, StartDate FROM Production.WorkOrder
WHERE ProductID = 945 AND StartDate = '2006-01-04'!--