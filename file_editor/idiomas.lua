-- ****************************************************************************
--
-- RECURSO: file_editor
-- ARCHIVO: idiomas.lua
-- PROPOSITO: Carga de idiomas de programación.
-- CREADORES: Stefano Aguilera Humeney < Gothem >
--
-- ****************************************************************************

C_idiomas = {}
C_idiomas.archivos = {}

addEvent ( 'fe_load', true )
function C_idiomas.HL_enviar ()

  if DEBUG then
  
    outputDebugString ( 'client loaded info received, sending languages...' )
  
  end

  C_idiomas.Enviar ( client )

end
addEventHandler ( 'fe_load', resourceRoot, C_idiomas.HL_enviar, false )

function C_idiomas.Enviar ( jugador )

  triggerClientEvent ( jugador, 'fe_idiomas', resourceRoot, C_idiomas.archivos )

end

function C_idiomas.Load ()

  local archivo = fileOpen('meta.xml')
  
  local str = ''
  while true do
  
    if fileIsEOF(archivo) then
      
      break -- Si es que se llega alfinal del texto, se rompe la iteración
        
    end
      
    str = str .. fileRead(archivo,300)
  
  end
  
  str:gsub ( '<file src="idiomas/(.-).txt', function( p )
  
    table.insert( C_idiomas.archivos, p )
  
  end ) 

  archivo:close()
  
  outputChatBox( 'File_editor ' .. getResourceInfo ( resource, 'version' ) .. ' se a iniciado!' )

end
addEventHandler('onResourceStart',resourceRoot,C_idiomas.Load, false)

function C_idiomas.H_enviar ()

  C_idiomas.Enviar ( source )

end
addEventHandler ('onPlayerJoin', root, C_idiomas.H_enviar)