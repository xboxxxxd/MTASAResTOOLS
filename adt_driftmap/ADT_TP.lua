function tp (thePlayer)
	setElementPosition ( thePlayer, 1191.9536132813, -864.30963134766, 105.9440612793 )
		outputChatBox ('#FFFFFF[#7CFC00TP#FFFFFF]: #00FFFF' .. getPlayerName(thePlayer) .. ' #00BFFFTeleported to Air Drift Track! #FFFFFF(#7CFC00/adt#FFFFFF)', root, 255, 255, 255, true)
end
addCommandHandler ( "adt", tp )