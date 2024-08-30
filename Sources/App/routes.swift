import Vapor

func routes(_ app: Application) throws {
    let calendarURL = URL(string: "https://calendar.google.com/calendar/ical/6df9fe259f4cb910df76fec5e2513231a6f5344b8b0ced9aa02b38defb038b13%40group.calendar.google.com/public/basic.ics")!
    
    app.get("calendar") { req async throws -> Response in
        let data = try Data(contentsOf: calendarURL)
        let tempURL = URL(fileURLWithPath: NSTemporaryDirectory().appending(UUID().uuidString + ".ics"))
        try data.write(to: tempURL)
        return try await req.fileio.asyncStreamFile(at: tempURL.path())
    }
}
