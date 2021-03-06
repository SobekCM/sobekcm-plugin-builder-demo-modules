select * from SobekCM_Builder_Module_Set

-- FOLDER MODULE

-- Get the module set id from one of the incoming folders
declare @modulesetid int;
set @modulesetid = coalesce((select top 1 ModuleSetID from SobekCM_Builder_Incoming_Folders), 10 );

-- Insert into the beginning
if ( ( select count(*) from SobekCM_Builder_Module where Class='CodeCamp2017.CustomNonBibFolders' ) = 0 )
begin
	insert into SobekCM_Builder_Module ( ModuleSetID, ModuleDesc, [Assembly], Class, [Enabled], [Order] )
	values ( @modulesetid, 'Handle non-Bib type incoming packages with no metadata', 'CodeCampBuilderPlugin', 'CodeCamp2017.CustomNonBibFolders', 1, 0 );
end
GO

-- INCOMING ITEM PROCESSING
-- ModuleSetID 3

declare @item_modulesetid int;
set @item_modulesetid = ( select top 1 ModuleSetId from SobekCM_Builder_Module_Set S, SobekCM_Builder_Module_Type T where S.ModuleTypeID=T.ModuleTypeID and T.TypeAbbrev='NEW');

if ( ( select count(*) from SobekCM_Builder_Module where Class='CodeCamp2017.ExternallyLogBuilderWork' ) = 0 )
begin
	insert into SobekCM_Builder_Module ( ModuleSetID, ModuleDesc, [Assembly], Class, [Enabled], [Order] )
	values ( @item_modulesetid, 'Externally log that this item was picked up by the builder', 'CodeCampBuilderPlugin', 'CodeCamp2017.ExternallyLogBuilderWork', 1, 0 );
end;
GO
