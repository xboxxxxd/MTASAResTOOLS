-- ****************************************************************************
--
-- RECURSO: file_editor
-- ARCHIVO: locale.lua
-- PROPOSITO: Carga de localización.
-- CREADORES: Stefano Aguilera Humeney < Gothem >
--
-- ****************************************************************************

C_locale = {}
C_locale.idiomas = { 'es','en_US'}

if getLocalization then

  C_locale.code = getLocalization()['code']
  localPlayer:setData ( 'fe_locale', C_locale.code )

end

for k,v in ipairs ( C_locale.idiomas ) do
  
  C_locale[v] = {}
  
  local f_archivo = fileOpen('locale/' .. v .. '.txt')
  
  local str = ''
  while true do
  
    local final = string.find(str,"\n")
    
    if not final then
    
      if fileIsEOF(f_archivo) then
      
        break -- Si es que se llega alfinal del texto, se rompe la iteración
        
      end
      
      str = str .. fileRead(f_archivo,300)
      
    else
    
      local linea = string.sub(str,1,final-1)
      str = string.sub(str,final+1)
      
      local data = split ( linea, '|' ) -- Se dividen los datos por el caracter '|'
      for a,s in ipairs ( data ) do
      
        data[a] = s:match'^()%s*$' and '' or s:match'^%s*(.*%S)' -- Se limpian posibles espacios de la variable
        
      end
      
      C_locale[v][data[1]] = data[2]
      
    end
  
  end
  
  f_archivo:close()

end

