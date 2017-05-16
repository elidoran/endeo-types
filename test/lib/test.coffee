assert = require 'assert'

types = require '../../lib/index.coffee'

describe 'test types', ->

  it 'should encode day', ->

    prepare = year = month = day = null
    output =
      prepare: (p) -> prepare = p
      short  : (y) -> year = y
      byte2  : (m, d) -> month = m ; day = d

    types.day.encode null, new Date(1901, 2, 3), output
    assert.equal prepare, 4
    assert.equal year, 1901
    assert.equal month, 2
    assert.equal day, 3

  it 'should decode day', ->

    values = [ 1901, 2, 3 ]
    input =
      short: -> values.shift()
      byte : -> values.shift()
    date = types.day.decode null, input
    assert.equal date.getFullYear(), 1901
    assert.equal date.getMonth(), 2
    assert.equal date.getDate(), 3

  it 'should decoderNode day', ->

    nexted = false
    control = next: -> nexted = true
    values = [ 1901, 2, 3 ]
    context =
      hasBytes: (n) -> n is 4
      short: -> values.shift()
      byte : -> values.shift()
    types.day.decoderNode control, context
    assert nexted
    assert.equal context.value.getFullYear(), 1901
    assert.equal context.value.getMonth(), 2
    assert.equal context.value.getDate(), 3

  it 'should wait in decoderNode day', ->

    waited = false
    control = wait: -> waited = true
    context = hasBytes: (n) -> if n is 4 then false else true
    types.day.decoderNode control, context
    assert waited
