function parse_num(str)
  result = conky_parse(str)
  if result == nil then return nil end

  return tonumber(result)
end

function conky_pad2(str)
  num = parse_num(str)
  if num == nil then return '' end

  return string.format('%2u', num)
end

function conky_pad3(str)
  num = parse_num(str)
  if num == nil then return '' end

  return string.format('%3u', num)
end

function conky_pad31(str)
  num = parse_num(str)
  if num == nil then return end

  return string.format('%5.1f', num)
end

function conky_pad4(str)
  num = parse_num(str)
  if num == nil then return '' end

  return string.format('%4u', num)
end

function conky_pad41(str)
  num = parse_num(str)
  if num == nil then return '' end

  return string.format('%6.1f', num)
end
