enum NetworkBuilder {
    static func build() -> Network {
        let session = NetworkProvider()
        let deserialization = NetworkDeserialization()
        let appConfigurationProvider = AppConfigurationProvider()

        return Network(
            session: session,
            deserialization: deserialization,
            configuration: appConfigurationProvider
        )
    }
}
