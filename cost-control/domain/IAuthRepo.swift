protocol IAuthRepo {
    func authenticate() async -> Bool
}
