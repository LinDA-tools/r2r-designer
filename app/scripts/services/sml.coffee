'use strict'

angular.module 'r2rDesignerApp'
  .factory 'Sml', (_, Csv) ->

    newLookup = () ->
      index: 0
      table: {}

    getVar = (key, lookup) ->
      found = lookup.table[key]
      if found
        return found
      else
        new_entry = '?x' + lookup.index++
        lookup.table[key] = new_entry
        new_entry

    toClasses = (mapping, table) ->
      if !mapping.classes[table]?
        return '\n'
      classes = ('a ' + c.prefixedName[0] for c in mapping.classes[table])
      if _.isEmpty classes
        return '\n'
      else
        return (_.foldl classes, ((x, y) -> (x + ';\n').concat(y))) + ';'

    toProperties = (mapping, table, lookup) ->
      columns = _.keys mapping.properties[table]
      properties = (mapping.properties[table][c].prefixedName[0] + ' ' + getVar(c, lookup) for c in columns)
      if _.isEmpty properties
        return '\n'
      else
        return _.foldl properties, ((x, y) -> (x + ';\n').concat(y))

    columnToVar = (column) ->
      '?' + column.substring(1, column.length-1)

    subjectTemplate = (mapping, table) ->
      if _.isEmpty mapping.subjectTemplate
        if _.isEmpty mapping.baseUri
          return """?s = bNode(concat('#{table}', '_'))\n""" # TODO: independently refer to primary key column
        else
          return """?s = bNode(concat('#{mapping.baseUri}', '_'))\n""" # TODO: independently refer to primary key column
      else
        template = mapping.subjectTemplate
        template = template.replace /{[^}]*}/g, (i) -> ';$;' + (columnToVar i) + ';$;'
        template = template.split ';$;'
        template = _.filter template, (i) -> !(_.isEmpty i)
        template = _.map template, (i) ->
          if i[0] == '?'
            i
          else
            "'" + i + "'"
        template = """concat('#{mapping.baseUri}', #{template})"""

        if _.isEmpty mapping.baseUri
          return '?s = bNode(' + template + ')' # TODO!
        else
          return '?s = uri(' + template + ')' # TODO!

    # columnsToNum = (table, selected) ->
    #   if table? and selected?
    #     _.map selected, (i) -> _.indexOf _.first csvData[table], i

    columnToNum = (table, column) ->
      if table? and column?
        _.indexOf Csv.columns(table), column

    propertyLiterals = (mapping, table, lookup) ->
      literals = mapping.literals
      types = mapping.literalTypes

      columns = _.keys mapping.properties[table]
      columns = _.filter columns, (i) ->
        property = mapping.properties[table][i].prefixedName[0]
        return (literals[property] or ((litearls[property] == 'Typed Literal') and types[property]))
     
      properties = _.map columns, (i) ->
        property = mapping.properties[table][i].prefixedName[0]
        switch literals[property]
          when 'Blank Node' then lookup[property] = (getVar i, lookup) + ' = bNode(?' + (columnToNum table, i) + ')'
          when 'Plain Literal' then lookup[property] = (getVar i, lookup) + ' = plainLiteral(?' + (columnToNum table, i) + ')'
          when 'Typed Literal' then lookup[property] = (getVar i, lookup) + ' = typedLiteral(?' + (columnToNum table, i) + ', ' + types[property] + ')'
          else ''
      
      if _.isEmpty properties
        return ''
      else
        return _.foldl properties, ((x, y) -> (x + '\n').concat(y))

    namespacePrefixes = (mapping) ->
      baseUris = [
        'Prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>'
        'Prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>'
        'Prefix xsd: <http://www.w3.org/2001/XMLSchema#>'
      ]

      suggestions = (_.flatten (_.values mapping.classes).concat (_.map (_.values mapping.properties), _.values))

      suggestedUris = (_.without (_.map suggestions, (i) ->
        if i['vocabulary.prefix']? and i['vocabulary.uri']?
          return """Prefix #{_.first i['vocabulary.prefix']}: <#{_.first i['vocabulary.uri']}>"""
        else
          return null
      ), null)

      baseUri =
        if !_.isEmpty(mapping.baseUri)
          ["""Prefix tns: <#{mapping.baseUri}>"""]
        else
          []

      return (_.foldl (baseUris.concat suggestedUris, baseUri), ((x, y) -> (x + '\n').concat y))

    createClause = (mapping, table) ->
      if mapping.source == 'csv'
        "Create View Template " + (table.replace /[^\w]/g, '') + " As"
      else
        "Create View " + (table.replace /[^\w]/g, '') + " As"

    fromClause = (mapping, table) ->
      if (mapping.source == 'rdb')
        "From " + table
      else
        ""
      
    {
      toSml: (mapping) ->
        # TODO: will only process the first table!
        table = mapping.tables[0]

        lookup = newLookup()

        return """
#{namespacePrefixes mapping}

#{createClause mapping, table}
    Construct {
        ?s 
#{toClasses mapping, table}
#{toProperties mapping, table, lookup}.
    }
    With
#{subjectTemplate mapping, table}
#{propertyLiterals mapping, table, lookup}
#{fromClause mapping, table}
        """
    }
