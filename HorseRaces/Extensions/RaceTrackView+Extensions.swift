import UIKit

extension RaceTrackView {
    func stopAllHorses() {
        horseViews.forEach {
            $0.stopRace()
            if let presentationFrame = $0.layer.presentation()?.frame {
                $0.frame = presentationFrame
            }
        }
    }
}
