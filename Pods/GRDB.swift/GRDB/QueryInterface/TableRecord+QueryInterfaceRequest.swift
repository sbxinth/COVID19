extension TableRecord {
    
    // MARK: Request Derivation
    
    static var relationForAll: SQLRelation {
        .all(fromTable: databaseTableName, selection: { _ in databaseSelection.map(\.sqlSelection) })
    }
    
    /// Creates a request which fetches all records.
    ///
    ///     // SELECT * FROM player
    ///     let request = Player.all()
    ///
    /// The selection defaults to all columns. This default can be changed for
    /// all requests by the `TableRecord.databaseSelection` property, or
    /// for individual requests with the `TableRecord.select` method.
    public static func all() -> QueryInterfaceRequest<Self> {
        QueryInterfaceRequest(relation: relationForAll)
    }
    
    /// Creates a request which fetches no record.
    public static func none() -> QueryInterfaceRequest<Self> {
        all().none() // don't laugh
    }
    
    /// Creates a request which selects *selection*.
    ///
    ///     // SELECT id, email FROM player
    ///     let request = Player.select(Column("id"), Column("email"))
    public static func select(_ selection: SQLSelectable...) -> QueryInterfaceRequest<Self> {
        all().select(selection)
    }
    
    /// Creates a request which selects *selection*.
    ///
    ///     // SELECT id, email FROM player
    ///     let request = Player.select([Column("id"), Column("email")])
    public static func select(_ selection: [SQLSelectable]) -> QueryInterfaceRequest<Self> {
        all().select(selection)
    }
    
    /// Creates a request which selects *sql*.
    ///
    ///     // SELECT id, email FROM player
    ///     let request = Player.select(sql: "id, email")
    public static func select(
        sql: String,
        arguments: StatementArguments = StatementArguments())
    -> QueryInterfaceRequest<Self>
    {
        select(literal: SQLLiteral(sql: sql, arguments: arguments))
    }
    
    /// Creates a request which selects an SQL *literal*.
    ///
    ///     // SELECT id, email FROM player
    ///     let request = Player.select(literal: SQLLiteral(sql: "id, email"))
    public static func select(literal sqlLiteral: SQLLiteral) -> QueryInterfaceRequest<Self> {
        all().select(literal: sqlLiteral)
    }
    
    /// Creates a request which selects *selection*, and fetches values of
    /// type *type*.
    ///
    ///     try dbQueue.read { db in
    ///         // SELECT max(score) FROM player
    ///         let request = Player.select([max(Column("score"))], as: Int.self)
    ///         let maxScore: Int? = try request.fetchOne(db)
    ///     }
    public static func select<RowDecoder>(
        _ selection: [SQLSelectable],
        as type: RowDecoder.Type = RowDecoder.self)
    -> QueryInterfaceRequest<RowDecoder>
    {
        all().select(selection, as: type)
    }
    
    /// Creates a request which selects *selection*, and fetches values of
    /// type *type*.
    ///
    ///     try dbQueue.read { db in
    ///         // SELECT max(score) FROM player
    ///         let request = Player.select(max(Column("score")), as: Int.self)
    ///         let maxScore: Int? = try request.fetchOne(db)
    ///     }
    public static func select<RowDecoder>(
        _ selection: SQLSelectable...,
        as type: RowDecoder.Type = RowDecoder.self)
    -> QueryInterfaceRequest<RowDecoder>
    {
        all().select(selection, as: type)
    }
    
    /// Creates a request which selects *sql*, and fetches values of
    /// type *type*.
    ///
    ///     try dbQueue.read { db in
    ///         // SELECT max(score) FROM player
    ///         let request = Player.select(sql: "max(score)", as: Int.self)
    ///         let maxScore: Int? = try request.fetchOne(db)
    ///     }
    public static func select<RowDecoder>(
        sql: String,
        arguments: StatementArguments = StatementArguments(),
        as type: RowDecoder.Type = RowDecoder.self)
    -> QueryInterfaceRequest<RowDecoder>
    {
        all().select(literal: SQLLiteral(sql: sql, arguments: arguments), as: type)
    }
    
    /// Creates a request which selects an SQL *literal*, and fetches values of
    /// type *type*.
    ///
    ///     try dbQueue.read { db in
    ///         // SELECT max(score) FROM player
    ///         let request = Player.select(literal: SQLLiteral(sql: "max(score)"), as: Int.self)
    ///         let maxScore: Int? = try request.fetchOne(db)
    ///     }
    public static func select<RowDecoder>(
        literal sqlLiteral: SQLLiteral,
        as type: RowDecoder.Type = RowDecoder.self)
    -> QueryInterfaceRequest<RowDecoder>
    {
        all().select(literal: sqlLiteral, as: type)
    }
    
    /// Creates a request which appends *selection*.
    ///
    ///     // SELECT id, email, name FROM player
    ///     le request = Player
    ///         .select([Column("id"), Column("email")])
    ///         .annotated(with: [Column("name")])
    public static func annotated(with selection: [SQLSelectable]) -> QueryInterfaceRequest<Self> {
        all().annotated(with: selection)
    }
    
    /// Creates a request which appends *selection*.
    ///
    ///     // SELECT id, email, name FROM player
    ///     le request = Player
    ///         .select([Column("id"), Column("email")])
    ///         .annotated(with: Column("name"))
    public static func annotated(with selection: SQLSelectable...) -> QueryInterfaceRequest<Self> {
        all().annotated(with: selection)
    }
    
    /// Creates a request with the provided *predicate*.
    ///
    ///     // SELECT * FROM player WHERE email = 'arthur@example.com'
    ///     let request = Player.filter(Column("email") == "arthur@example.com")
    ///
    /// The selection defaults to all columns. This default can be changed for
    /// all requests by the `TableRecord.databaseSelection` property, or
    /// for individual requests with the `TableRecord.select` method.
    @available(*, deprecated, message: "Did you mean filter(key: id)? If not, prefer filter(value.databaseValue) instead. See also all() and none().") // swiftlint:disable:this line_length
    public static func filter(_ predicate: SQLExpressible) -> QueryInterfaceRequest<Self> {
        all().filter(predicate.sqlExpression)
    }
    
    // Accept SQLSpecificExpressible instead of SQLExpressible, so that we
    // prevent the `Player.filter(42)` misuse.
    // See https://github.com/groue/GRDB.swift/pull/864
    /// Creates a request with the provided *predicate*.
    ///
    ///     // SELECT * FROM player WHERE email = 'arthur@example.com'
    ///     let request = Player.filter(Column("email") == "arthur@example.com")
    ///
    /// The selection defaults to all columns. This default can be changed for
    /// all requests by the `TableRecord.databaseSelection` property, or
    /// for individual requests with the `TableRecord.select` method.
    public static func filter(_ predicate: SQLSpecificExpressible) -> QueryInterfaceRequest<Self> {
        all().filter(predicate)
    }
    
    /// Creates a request with the provided primary key *predicate*.
    ///
    ///     // SELECT * FROM player WHERE id = 1
    ///     let request = Player.filter(key: 1)
    ///
    /// The selection defaults to all columns. This default can be changed for
    /// all requests by the `TableRecord.databaseSelection` property, or
    /// for individual requests with the `TableRecord.select` method.
    public static func filter<PrimaryKeyType>(key: PrimaryKeyType?)
    -> QueryInterfaceRequest<Self>
    where PrimaryKeyType: DatabaseValueConvertible
    {
        all().filter(key: key)
    }
    
    /// Creates a request with the provided primary key *predicate*.
    ///
    ///     // SELECT * FROM player WHERE id IN (1, 2, 3)
    ///     let request = Player.filter(keys: [1, 2, 3])
    ///
    /// The selection defaults to all columns. This default can be changed for
    /// all requests by the `TableRecord.databaseSelection` property, or
    /// for individual requests with the `TableRecord.select` method.
    public static func filter<Sequence>(keys: Sequence)
    -> QueryInterfaceRequest<Self>
    where Sequence: Swift.Sequence, Sequence.Element: DatabaseValueConvertible
    {
        all().filter(keys: keys)
    }
    
    /// Creates a request with the provided primary key *predicate*.
    ///
    ///     // SELECT * FROM passport WHERE personId = 1 AND countryCode = 'FR'
    ///     let request = Passport.filter(key: ["personId": 1, "countryCode": "FR"])
    ///
    /// When executed, this request raises a fatal error if there is no unique
    /// index on the key columns.
    ///
    /// The selection defaults to all columns. This default can be changed for
    /// all requests by the `TableRecord.databaseSelection` property, or
    /// for individual requests with the `TableRecord.select` method.
    public static func filter(key: [String: DatabaseValueConvertible?]?) -> QueryInterfaceRequest<Self> {
        all().filter(key: key)
    }
    
    /// Creates a request with the provided primary key *predicate*.
    ///
    ///     // SELECT * FROM passport WHERE (personId = 1 AND countryCode = 'FR') OR ...
    ///     let request = Passport.filter(keys: [["personId": 1, "countryCode": "FR"], ...])
    ///
    /// When executed, this request raises a fatal error if there is no unique
    /// index on the key columns.
    ///
    /// The selection defaults to all columns. This default can be changed for
    /// all requests by the `TableRecord.databaseSelection` property, or
    /// for individual requests with the `TableRecord.select` method.
    public static func filter(keys: [[String: DatabaseValueConvertible?]]) -> QueryInterfaceRequest<Self> {
        all().filter(keys: keys)
    }
    
    /// Creates a request with the provided *predicate*.
    ///
    ///     // SELECT * FROM player WHERE email = 'arthur@example.com'
    ///     let request = Player.filter(sql: "email = ?", arguments: ["arthur@example.com"])
    ///
    /// The selection defaults to all columns. This default can be changed for
    /// all requests by the `TableRecord.databaseSelection` property, or
    /// for individual requests with the `TableRecord.select` method.
    public static func filter(
        sql: String,
        arguments: StatementArguments = StatementArguments())
    -> QueryInterfaceRequest<Self>
    {
        filter(literal: SQLLiteral(sql: sql, arguments: arguments))
    }
    
    /// Creates a request with the provided *predicate*.
    ///
    ///     // SELECT * FROM player WHERE email = 'arthur@example.com'
    ///     let request = Player.filter(literal: SQLLiteral(sql: "email = ?", arguments: ["arthur@example.com"]))
    ///
    /// With Swift 5, you can safely embed raw values in your SQL queries,
    /// without any risk of syntax errors or SQL injection:
    ///
    ///     let request = Player.filter(literal: "name = \("O'Brien"))
    ///
    /// The selection defaults to all columns. This default can be changed for
    /// all requests by the `TableRecord.databaseSelection` property, or
    /// for individual requests with the `TableRecord.select` method.
    public static func filter(literal sqlLiteral: SQLLiteral) -> QueryInterfaceRequest<Self> {
        // NOT TESTED
        all().filter(literal: sqlLiteral)
    }
    
    /// Creates a request sorted according to the
    /// provided *orderings*.
    ///
    ///     // SELECT * FROM player ORDER BY name
    ///     let request = Player.order(Column("name"))
    ///
    /// The selection defaults to all columns. This default can be changed for
    /// all requests by the `TableRecord.databaseSelection` property, or
    /// for individual requests with the `TableRecord.select` method.
    public static func order(_ orderings: SQLOrderingTerm...) -> QueryInterfaceRequest<Self> {
        all().order(orderings)
    }
    
    /// Creates a request sorted according to the
    /// provided *orderings*.
    ///
    ///     // SELECT * FROM player ORDER BY name
    ///     let request = Player.order([Column("name")])
    ///
    /// The selection defaults to all columns. This default can be changed for
    /// all requests by the `TableRecord.databaseSelection` property, or
    /// for individual requests with the `TableRecord.select` method.
    public static func order(_ orderings: [SQLOrderingTerm]) -> QueryInterfaceRequest<Self> {
        all().order(orderings)
    }
    
    /// Creates a request sorted by primary key.
    ///
    ///     // SELECT * FROM player ORDER BY id
    ///     let request = Player.orderByPrimaryKey()
    ///
    ///     // SELECT * FROM country ORDER BY code
    ///     let request = Country.orderByPrimaryKey()
    ///
    /// The selection defaults to all columns. This default can be changed for
    /// all requests by the `TableRecord.databaseSelection` property, or
    /// for individual requests with the `TableRecord.select` method.
    public static func orderByPrimaryKey() -> QueryInterfaceRequest<Self> {
        all().orderByPrimaryKey()
    }
    
    /// Creates a request sorted according to *sql*.
    ///
    ///     // SELECT * FROM player ORDER BY name
    ///     let request = Player.order(sql: "name")
    ///
    /// The selection defaults to all columns. This default can be changed for
    /// all requests by the `TableRecord.databaseSelection` property, or
    /// for individual requests with the `TableRecord.select` method.
    public static func order(
        sql: String,
        arguments: StatementArguments = StatementArguments())
    -> QueryInterfaceRequest<Self>
    {
        all().order(literal: SQLLiteral(sql: sql, arguments: arguments))
    }
    
    /// Creates a request sorted according to an SQL *literal*.
    ///
    ///     // SELECT * FROM player ORDER BY name
    ///     let request = Player.order(literal: SQLLiteral(sql: "name"))
    ///
    /// With Swift 5, you can safely embed raw values in your SQL queries,
    /// without any risk of syntax errors or SQL injection:
    ///
    ///     // SELECT * FROM player ORDER BY name
    ///     let request = Player.order(literal: "name"))
    ///
    /// The selection defaults to all columns. This default can be changed for
    /// all requests by the `TableRecord.databaseSelection` property, or
    /// for individual requests with the `TableRecord.select` method.
    public static func order(literal sqlLiteral: SQLLiteral) -> QueryInterfaceRequest<Self> {
        all().order(literal: sqlLiteral)
    }
    
    /// Creates a request which fetches *limit* rows, starting at
    /// *offset*.
    ///
    ///     // SELECT * FROM player LIMIT 1
    ///     let request = Player.limit(1)
    ///
    /// The selection defaults to all columns. This default can be changed for
    /// all requests by the `TableRecord.databaseSelection` property, or
    /// for individual requests with the `TableRecord.select` method.
    public static func limit(_ limit: Int, offset: Int? = nil) -> QueryInterfaceRequest<Self> {
        all().limit(limit, offset: offset)
    }
    
    /// Creates a request that allows you to define expressions that target
    /// a specific database table.
    ///
    /// In the example below, the "team.avgScore < player.score" condition in
    /// the ON clause could be not achieved without table aliases.
    ///
    ///     struct Player: TableRecord {
    ///         static let team = belongsTo(Team.self)
    ///     }
    ///
    ///     // SELECT player.*, team.*
    ///     // JOIN team ON ... AND team.avgScore < player.score
    ///     let playerAlias = TableAlias()
    ///     let request = Player
    ///         .aliased(playerAlias)
    ///         .including(required: Player.team.filter(Column("avgScore") < playerAlias[Column("score")])
    public static func aliased(_ alias: TableAlias) -> QueryInterfaceRequest<Self> {
        all().aliased(alias)
    }
    
    /// Returns a request which embeds the common table expression.
    ///
    /// If a common table expression with the same table name had already been
    /// embedded, it is replaced by the new one.
    ///
    /// For example, you can build a request that fetches all chats with their
    /// latest post:
    ///
    ///     let latestMessageRequest = Message
    ///         .annotated(with: max(Column("date")))
    ///         .group(Column("chatID"))
    ///
    ///     let latestMessageCTE = CommonTableExpression(
    ///         named: "latestMessage",
    ///         request: latestMessageRequest)
    ///
    ///     let latestMessage = Chat.association(
    ///         to: latestMessageCTE,
    ///         on: { chat, latestMessage in
    ///             chat[Column("id")] == latestMessage[Column("chatID")]
    ///         })
    ///
    ///     // WITH latestMessage AS
    ///     //   (SELECT *, MAX(date) FROM message GROUP BY chatID)
    ///     // SELECT chat.*, latestMessage.*
    ///     // FROM chat
    ///     // LEFT JOIN latestMessage ON chat.id = latestMessage.chatID
    ///     let request = Chat
    ///         .with(latestMessageCTE)
    ///         .including(optional: latestMessage)
    ///
    /// - parameter cte: A common table expression.
    /// - returns: A request.
    public static func with<RowDecoder>(_ cte: CommonTableExpression<RowDecoder>) -> QueryInterfaceRequest<Self> {
        all().with(cte)
    }
}
