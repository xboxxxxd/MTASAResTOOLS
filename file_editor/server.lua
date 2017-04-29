-- ****************************************************************************
--
-- RECURSO: file_editor
-- ARCHIVO: server.lua
-- PROPOSITO: Codigo de servidor.
-- CREADORES: Stefano Aguilera Humeney < Gothem >
--
-- ****************************************************************************

DEBUG = false

function abrirArchivo ( jugador, _, ruta )
  
  local locale = jugador:getData ( 'fe_locale' )

  local f_archivo = jugador:getData ( 'fe_archivo' )
  if isElement ( f_archivo ) then
  
    f_archivo:close()
  
  end

  local f_archivo = File ( ruta )
  if not f_archivo then
  
    outputChatBox(C_locale[locale].FILE_ERROR)
    return
  
  end
  
  local buffer = ''
  while not f_archivo:isEOF() do
			
    buffer = buffer .. f_archivo:read(1000)

  
  end
  
  outputChatBox ( jugador.name .. ' ' .. C_locale[locale].FILE_OPEN ..' ' .. ruta)
  
  jugador:setData ( 'fe_archivo', f_archivo, false )
  
  triggerClientEvent ( jugador, 'fe_abrir', resourceRoot, buffer, utf8.match(ruta,'%.(.+)') )
  
end
addCommandHandler ('abrir',abrirArchivo)
addCommandHandler ('open',abrirArchivo)

addEvent ( "fe_guardar", true )
function guardarArchivo ( contenido )

  local locale = client:getData ( 'fe_locale' )

  local archivo = client:getData("fe_archivo")
  if not archivo then 
    
    outputChatBox ( C_locale[locale].FILE_SAVE_ERROR .. " " .. client.name)
    return 
  
  end
  
  archivo.pos = 0
  archivo:write ( contenido )
  archivo:close ()
  
  client:removeData('fe_archivo')
  
  outputChatBox ( C_locale[locale].FILE_SAVE )

end
addEventHandler ( "fe_guardar", resourceRoot, guardarArchivo, false )