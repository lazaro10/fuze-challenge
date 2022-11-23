enum NetworkDownloadBuilder {
    static func build() -> NetworkDownload {
        let session = NetworkProvider()
        let cacheManager = CacheManager(fileManager: FileManagerProvider())

        return NetworkDownload(session: session, cacheManager: cacheManager)
     //   return NetworkDownload(session: session, fileManagerProvdider: FileManagerProvider())
    }
}
