-----------------------------------
-- Area: dynamis_Tavnazia
-- Name: dynamis_Tavnazia
-----------------------------------



-- After registering the BCNM via bcnmRegister(bcnmid)
function onBcnmRegister(player,instance)

	SetServerVariable("[DynaTavnazia]UniqueID",player:getDynamisUniqueID(1289));
	SetServerVariable("[DynaTavnazia]Boss_Trigger",0);
	SetServerVariable("[DynaTavnazia]Already_Received",0);
	
end;

-- Physically entering the BCNM via bcnmEnter(bcnmid)
function onBcnmEnter(player,instance)
	
	player:setVar("DynamisID",GetServerVariable("[DynaTavnazia]UniqueID"));
	local realDay = os.time();
    local dynaWaitxDay = player:getVar("dynaWaitxDay");

    if ((dynaWaitxDay + (BETWEEN_2DYNA_WAIT_TIME * 24 * 60 * 60)) < realDay) then
		player:setVar("dynaWaitxDay",realDay);
	end
   local relicid = player:getVar( "RelicID" );
   local dynaid = player:getVar( "DynamisID" );

   if( relicid == dynaid or relicid == -2 ) then
      if( player:getFreeSlotsCount() <= 0 ) then
         player:PrintToPlayer( "Your inventory is full. Clear it and rezone.", 0xE );
         return;
      end
      player:addItem( player:getVar( "RelicBought" ) );
      player:messageSpecial( ITEM_OBTAINED, player:getVar( "RelicBought" ) );
      if( relicid == -2 ) then player:setVar( "RelicBuys", -1 ); end
      player:setVar( "RelicID", dynaid );
   end
	
end;

-- Leaving the Dynamis by every mean possible, given by the LeaveCode
-- 3=Disconnected or warped out (if dyna is empty: launch 4 after 3)
-- 4=Finish he dynamis

function onBcnmLeave(player,instance,leavecode)
--print("leave code "..leavecode);
	if(leavecode == 4) then
		SetServerVariable("[DynaTavnazia]UniqueID",0);
	end
	
end;
