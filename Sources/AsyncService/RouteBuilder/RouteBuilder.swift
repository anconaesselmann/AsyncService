//  Created by Axel Ancona Esselmann on 7/24/24.
//

import Foundation

@resultBuilder
public struct URLBuilder {

    public enum Error: Swift.Error {
        case invalidUrl
    }

    public static func buildBlock(_ route: URL, _ path: Path, _ queryParameters: [QueryP] = []) -> URL {
        route
            .appendingPathExtension(path.path)
            .appending(
                queryItems: queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
            )
    }

    public static func buildBlock(_ api: API, _ path: Path, queryParameters: [QueryP] = []) -> URL {
        let url = URL(string: api.domain)!.appendingPathExtension(path.path)
        return url.appending(queryItems: queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) })
    }

    public static func buildBlock(_ path: Path, _ queryParameters: [QueryP] = []) -> URLComponents {
        var components = URLComponents()
        components.path = path.path
        components.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        return components
    }

    public static func buildBlock(_ path: Path, _ q1: QueryP) -> URLComponents {
        buildBlock(path, [q1])
    }

    public static func buildBlock(
        _ path: Path,
        _ q1: QueryP,
        _ q2: QueryP
    ) -> URLComponents {
        buildBlock(path, [q1, q2])
    }
    
    public static func buildBlock(
        _ path: Path,
        _ q1: QueryP,
        _ q2: QueryP,
        _ q3: QueryP
    ) -> URLComponents {
        buildBlock(path, [q1, q2, q3])
    }

    public static func buildBlock(
        _ path: Path,
        _ q1: QueryP,
        _ q2: QueryP,
        _ q3: QueryP,
        _ q4: QueryP
    ) -> URLComponents {
        buildBlock(path, [q1, q2, q3, q4])
    }

    public static func buildBlock(
        _ path: Path,
        _ q1: QueryP,
        _ q2: QueryP,
        _ q3: QueryP,
        _ q4: QueryP,
        _ q5: QueryP
    ) -> URLComponents {
        buildBlock(path, [q1, q2, q3, q4, q5])
    }

    public static func buildBlock(
        _ path: Path,
        _ q1: QueryP,
        _ q2: QueryP,
        _ q3: QueryP,
        _ q4: QueryP,
        _ q5: QueryP,
        _ q6: QueryP
    ) -> URLComponents {
        buildBlock(path, [q1, q2, q3, q4, q5, q6])
    }

    public static func buildBlock(
        _ path: Path,
        _ q1: QueryP,
        _ q2: QueryP,
        _ q3: QueryP,
        _ q4: QueryP,
        _ q5: QueryP,
        _ q6: QueryP,
        _ q7: QueryP
    ) -> URLComponents {
        buildBlock(path, [q1, q2, q3, q4, q5, q6, q7])
    }

    public static func buildBlock(
        _ path: Path,
        _ q1: QueryP,
        _ q2: QueryP,
        _ q3: QueryP,
        _ q4: QueryP,
        _ q5: QueryP,
        _ q6: QueryP,
        _ q7: QueryP,
        _ q8: QueryP
    ) -> URLComponents {
        buildBlock(path, [q1, q2, q3, q4, q5, q6, q7, q8])
    }

    public static func buildBlock(
        _ path: Path,
        _ q1: QueryP,
        _ q2: QueryP,
        _ q3: QueryP,
        _ q4: QueryP,
        _ q5: QueryP,
        _ q6: QueryP,
        _ q7: QueryP,
        _ q8: QueryP,
        _ q9: QueryP
    ) -> URLComponents {
        buildBlock(path, [q1, q2, q3, q4, q5, q6, q7, q8, q9])
    }

    public static func buildBlock(
        _ path: Path,
        _ q1: QueryP,
        _ q2: QueryP,
        _ q3: QueryP,
        _ q4: QueryP,
        _ q5: QueryP,
        _ q6: QueryP,
        _ q7: QueryP,
        _ q8: QueryP,
        _ q9: QueryP,
        _ q10: QueryP
    ) -> URLComponents {
        buildBlock(path, [q1, q2, q3, q4, q5, q6, q7, q8, q9, q10])
    }

    public static func buildBlock(
        _ path: Path,
        _ q1: QueryP,
        _ q2: QueryP,
        _ q3: QueryP,
        _ q4: QueryP,
        _ q5: QueryP,
        _ q6: QueryP,
        _ q7: QueryP,
        _ q8: QueryP,
        _ q9: QueryP,
        _ q10: QueryP,
        _ q11: QueryP
    ) -> URLComponents {
        buildBlock(path, [q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11])
    }

    public static func buildBlock(
        _ path: Path,
        _ q1: QueryP,
        _ q2: QueryP,
        _ q3: QueryP,
        _ q4: QueryP,
        _ q5: QueryP,
        _ q6: QueryP,
        _ q7: QueryP,
        _ q8: QueryP,
        _ q9: QueryP,
        _ q10: QueryP,
        _ q11: QueryP,
        _ q12: QueryP
    ) -> URLComponents {
        buildBlock(path, [q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12])
    }

    public static func buildBlock(
        _ path: Path,
        _ q1: QueryP,
        _ q2: QueryP,
        _ q3: QueryP,
        _ q4: QueryP,
        _ q5: QueryP,
        _ q6: QueryP,
        _ q7: QueryP,
        _ q8: QueryP,
        _ q9: QueryP,
        _ q10: QueryP,
        _ q11: QueryP,
        _ q12: QueryP,
        _ q13: QueryP
    ) -> URLComponents {
        buildBlock(path, [q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13])
    }

    public static func buildBlock(
        _ path: Path,
        _ q1: QueryP,
        _ q2: QueryP,
        _ q3: QueryP,
        _ q4: QueryP,
        _ q5: QueryP,
        _ q6: QueryP,
        _ q7: QueryP,
        _ q8: QueryP,
        _ q9: QueryP,
        _ q10: QueryP,
        _ q11: QueryP,
        _ q12: QueryP,
        _ q13: QueryP,
        _ q14: QueryP
    ) -> URLComponents {
        buildBlock(path, [q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14])
    }

    public static func buildBlock(
        _ path: Path,
        _ q1: QueryP,
        _ q2: QueryP,
        _ q3: QueryP,
        _ q4: QueryP,
        _ q5: QueryP,
        _ q6: QueryP,
        _ q7: QueryP,
        _ q8: QueryP,
        _ q9: QueryP,
        _ q10: QueryP,
        _ q11: QueryP,
        _ q12: QueryP,
        _ q13: QueryP,
        _ q14: QueryP,
        _ q15: QueryP
    ) -> URLComponents {
        buildBlock(path, [q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15])
    }
}
