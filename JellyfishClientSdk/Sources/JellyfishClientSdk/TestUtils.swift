import MembraneRTC
import Starscream
import WebRTC

internal protocol JellyfishWebSocketDelegate {
    func websocketDidConnect()
    func websocketDidDisconnect(error: Error?)
    func websocketDidReceiveData(data: Data)
}

internal protocol JellyfishWebsocket: JellyfishWebSocketDelegate {
    var delegate: JellyfishWebSocketDelegate? { get set }
    func connect()
    func disconnect()
    func write(data: Data)
}

internal class JellyfishWebsocketWrapper: JellyfishWebsocket {
    var delegate: JellyfishWebSocketDelegate?
    var socket: WebSocket

    func websocketDidConnect() {}

    func websocketDidDisconnect(error: Error?) {}

    func websocketDidReceiveData(data: Data) {}

    public init(socket: WebSocket) {
        self.delegate = nil
        self.socket = socket
    }

    func connect() {
        socket.connect()
    }

    func disconnect() {
        socket.disconnect()
    }

    func write(data: Data) {
        socket.write(data: data)
    }
}

internal protocol JellyfishMembraneRTC {
    func disconnect()
    func receiveMediaEvent(mediaEvent: SerializedMediaEvent)
}

extension MembraneRTC: JellyfishMembraneRTC {}

internal func websocketFactory(url: String) -> JellyfishWebsocket {
    let url = URL(string: url)
    return JellyfishWebsocketWrapper(socket: WebSocket(url: url!))
}
