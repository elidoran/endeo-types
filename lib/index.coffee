# faster.
# instead of enbyte/debyte determining which type of value it is and then
# going to the proper operation, you can set the type with these and
# it will go directly to the proper operation.
module.exports =

  # YYYY/MM/DD value from a Date.
  # when all we care about is the exact day of a year then this is less bytes.
  day:
    encode: (enbyte, value, output) ->
      year = value.getFullYear()
      output.prepare 4
      output.short year
      output.byte2 value.getMonth(), value.getDate()
      return

    decode: (debyte, input) ->
      #           year      ,   month     , date (day of month)
      new Date input.short(), input.byte(), input.byte()

    decoderNode: (control, context) ->
      if context.hasBytes 4
        context.value = new Date context.short(), context.byte(), context.byte()
        control.next()
      else control.wait 'wait in day'

  # when all we care about is the hours and minutes from a Date, this is less bytes.
  time:  # 24-hour "hour" value...
    encode: (enbyte, value, output) -> output.byte2 value.getHours(), value.getMinutes()

    decode: (debyte, input) ->
      now = new Date
      new Date now.getFullYear(), now.getMonth(), now.getDate(), input.byte(), input.byte()

    decoderNode: (control, context) ->
      if context.hasBytes 2
        now = new Date()
        context.value = new Date now.getFullYear(), now.getMonth(), now.getDate(), context.byte(), context.byte()
        control.next()
      else control.wait 'wait in time'

  # TODO: add the time zone (offset).
  # zday:  # year/month/day + time zone offset
  # ztime: # hour:minute + time zone offset
  # OR: always use the UTC value

  # TODO: a type for sending an "object spec" (Special) itself.
  # reserve indicator byte value zero to be this...

  generic:
    encode: (enbyte, value, output) ->
      keys = Object.keys value
      enbyte.generic value, keys, output
    decode: (debyte, input) -> debyte.generic input

  special:
    encode: (enbyte, value, output) ->
      enbyte.special value.$ENDEO_SPECIAL, value, output
    decode: (debyte, input) -> debyte.special input

  num:
    encode: (enbyte, value, output) -> enbyte.num value, output
    decode: (debyte, input) -> debyte.num input

  int:
    encode: (enbyte, value, output) -> enbyte.int value, output
    decode: (debyte, input) -> debyte.int input

  int0:
    encode: (enbyte, value, output) -> enbyte.int0 value, output
    decode: (debyte, input) -> debyte.int0 input

  int1:
    encode: (enbyte, value, output) -> enbyte.int1 value, output
    decode: (debyte, input) -> debyte.int1 input

  int2:
    encode: (enbyte, value, output) -> enbyte.int2 value, output
    decode: (debyte, input) -> debyte.int2 input

  int3:
    encode: (enbyte, value, output) -> enbyte.int3 value, output
    decode: (debyte, input) -> debyte.int3 input

  int4:
    encode: (enbyte, value, output) -> enbyte.int4 value, output
    decode: (debyte, input) -> debyte.int4 input

  int5:
    encode: (enbyte, value, output) -> enbyte.int5 value, output
    decode: (debyte, input) -> debyte.int5 input

  int6:
    encode: (enbyte, value, output) -> enbyte.int6 value, output
    decode: (debyte, input) -> debyte.int6 input

  int7:
    encode: (enbyte, value, output) -> enbyte.int7 value, output
    decode: (debyte, input) -> debyte.int7 input

  int8:
    encode: (enbyte, value, output) -> enbyte.int8 value, output
    decode: (debyte, input) -> debyte.int8 input # read short + read 6

  float:
    encode: (enbyte, value, output) -> enbyte.float value, output
    decode: (debyte, input) -> debyte.float input

  float4:
    encode: (enbyte, value, output) -> enbyte.float4 value, output
    decode: (debyte, input) -> debyte.float4 input

  float8:
    encode: (enbyte, value, output) -> enbyte.float8 value, output
    decode: (debyte, input) -> debyte.float8 input
