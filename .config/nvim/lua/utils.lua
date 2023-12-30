local function getYearBeginDayOfWeek(tm)
  local yearBegin = os.time({ year = os.date("*t", tm).year, month = 1, day = 1 })
  local yearBeginDayOfWeek = tonumber(os.date("%w", yearBegin))
  -- sunday correct from 0 -> 7
  if yearBeginDayOfWeek == 0 then
    yearBeginDayOfWeek = 7
  end
  return yearBeginDayOfWeek
end

local function getDayAdd(tm)
  local yearBeginDayOfWeek = getYearBeginDayOfWeek(tm)
  if yearBeginDayOfWeek < 5 then
    -- first day is week 1
    return (yearBeginDayOfWeek - 2)
  else
    -- first day is week 52 or 53
    return (yearBeginDayOfWeek - 9)
  end
end

local function getWeekNumberOfYear(tm)
  local dayOfYear = os.date("%j", tm)
  local dayAdd = getDayAdd(tm)
  local dayOfYearCorrected = dayOfYear + dayAdd

  if dayOfYearCorrected < 0 then
    -- week of last year - decide if 52 or 53
    local lastYearBegin = os.time({ year = os.date("*t", tm).year - 1, month = 1, day = 1 })
    local lastYearEnd = os.time({ year = os.date("*t", tm).year - 1, month = 12, day = 31 })
    dayAdd = getDayAdd(lastYearBegin)
    dayOfYear = dayOfYear + os.date("%j", lastYearEnd)
    dayOfYearCorrected = dayOfYear + dayAdd
  end

  local weekNum = math.floor(dayOfYearCorrected / 7) + 1
  if (dayOfYearCorrected > 0) and weekNum == 53 then
    -- check if it is not considered as part of week 1 of next year
    local nextYearBegin = os.time({ year = os.date("*t", tm).year + 1, month = 1, day = 1 })
    local yearBeginDayOfWeek = getYearBeginDayOfWeek(nextYearBegin)
    if yearBeginDayOfWeek < 5 then
      weekNum = 1
    end
  end
  return weekNum
end

local function file_exists(name)
  local f = io.open(name, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

return {
  getWeekNumberOfYear = getWeekNumberOfYear,
  file_exists = file_exists,
}
