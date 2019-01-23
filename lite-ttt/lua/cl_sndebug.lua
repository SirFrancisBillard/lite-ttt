sound.PlayURL ( "https://sirfrancisbillard.github.io/billard-radio/sound/jihad/jihad_1.mp3", "", function( station, errid, errname )
	if ( IsValid( station ) ) then

		station:SetPos( LocalPlayer():GetPos() )

		station:Play()

	else

		LocalPlayer():ChatPrint( "Invalid URL!" .. tostring(errid) .. tostring(errname) )

	end
end )