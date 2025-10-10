import Foundation

@main
class EnvVarsCreateScript {

    public static var fileManager = FileManager.default

    public enum IOError: Error {
       case envFileIsMissing
       case envReadFileFailed
    }

    public enum ParseError: Error {
       case malformedKeyValuePair
   }

    static func main() throws {
        do {
            let varDict = try readLines(".env")
            try writeEnvFile(varDict: varDict)
        } catch {
            throw error
        }
    }

    private static func readLines(_ path: String) throws -> [String: String] {
        var varDict: [String: String] = [:]
        let contents = try readFile(path)
        let lines = contents.split(separator: "\n")

        for line in lines {
            if line.starts(with: "#") {
                continue
            }

            let substrings = line.split(separator: "=")

            guard
                let key = substrings.first?.trimmingCharacters(in: .whitespacesAndNewlines),
                let value = substrings.last?.trimmingCharacters(in: .whitespacesAndNewlines),
                substrings.count == 2,
                !key.isEmpty,
                !value.isEmpty else {
                throw ParseError.malformedKeyValuePair
            }

            let formattedKey = key.camelCased()
            varDict[formattedKey] = value
        }

        return varDict
    }

    private static func writeEnvFile(varDict: [String: String]) throws {
        var fileString = "// Generated, do not create manually\n\n"
        fileString.append("import Foundation\n\n")
        fileString.append("struct EnvVars {\n")
        for (key, value) in varDict {
            fileString.append("\tlet \(key) = \"\(value)\"\n")
        }

        fileString.append("\n}\n")

        fileManager.createFile(atPath: "iScream/Environment/EnvVars.swift", contents: fileString.data(using: .utf8))
    }

    private static func readFile(_ path: String) throws -> String {
            let fileManager = Self.fileManager
            guard fileManager.fileExists(atPath: path) else {
                throw IOError.envFileIsMissing
            }
        guard let contents = try? String(contentsOf: URL(fileURLWithPath: path), encoding: .utf8) else {
                throw IOError.envReadFileFailed
            }
        return contents
    }
}

extension String {
    func camelCased() -> String {
        return self
            .split(separator: "_")
            .map { String($0) }
            .enumerated()
            .map { $0.offset > 0 ? $0.element.capitalized : $0.element.lowercased() }
            .joined()
    }
}
