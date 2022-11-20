enum NetworkBuilder {
    static func build() -> Network {
        let session = NetworkProvider()
        let deserialization = NetworkDeserialization()
        let urlProvider = BaseURLProvider()
        let accessTokenProvider = AccessTokenProvider()

        return Network(
            session: session,
            deserialization: deserialization,
            urlProvider: urlProvider,
            accessTokenProvider: accessTokenProvider
        )
    }
}
