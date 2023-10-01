//
//  BeaconService.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/26.
//

import CoreLocation

typealias BeaconInfo = (String, Int, Int)

class BeaconService: NSObject, CLLocationManagerDelegate {
    @Published var detectedBeaconInfo: BeaconInfo = ("", 0, 0)
    
    private var detectedBeaconList: [BeaconInfo] = []
    private var locationManager: CLLocationManager    //앱에 대한 위치 관련 이벤트 전달을 시작하고 중지하도록 하는 인스턴스
    private var beaconUUIDList: [String]
    
    init(_ beaconUUIDList: [String]) {
        locationManager = CLLocationManager()
        self.beaconUUIDList = beaconUUIDList
        
        super.init()
        locationManager.delegate = self    //delegate로 위임
        locationManager.requestAlwaysAuthorization()    //위치 권한 요청
        locationManager.startUpdatingLocation()    //위치 업데이트 시작
    }
    
    //MARK: - 위치 권한이 업데이트 되거나 Location Manager가 생성될때 delegate로 호출되는 메서드
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedAlways || manager.authorizationStatus == .authorizedWhenInUse {
            monitorBeacons()
        }
    }
    
    //MARK: - Beacon Monitoring
    func monitorBeacons() {
        //CLLocationManager가 CLBeaconRegion을 모니터링 할 수 있는지 확인
        if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
            for uuid in beaconUUIDList {
                startScanning(for: uuid)
            }
        } else {
            print("monitorBeacons() - CLBeaconRegion can not monitor")
        }
    }
    
    func startScanning(for uuid: String) {
        let uuid: UUID = UUID(uuidString: uuid)!
        let beaconRegion: CLBeaconRegion = CLBeaconRegion(uuid: uuid, identifier: uuid.uuidString)
        let beaconConstraint: CLBeaconIdentityConstraint = CLBeaconIdentityConstraint(uuid: uuid)
        
        //범위에서 벗어나면 notification 발생
        beaconRegion.notifyOnExit = true    //locationManager(_:didExitRegion:) 호출
        //범위에서 들어오면 notification 발생
        beaconRegion.notifyOnEntry = true    //locationManager(_:didEnterRegion:) 호출
        
        self.locationManager.startMonitoring(for: beaconRegion)    //beaconRegion 모니터링 시작
        self.locationManager.startRangingBeacons(satisfying: beaconConstraint)    //beacon 모니터링 시작
    }
    
    //MARK: - Beacon 모니터링 시작하면 매초 수행할 함수
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        //탐지한 beacon이 있다면 beacons는 신호 강도가 가장 강한 순으로 정렬됨
        if beacons.count > 0 {
            for beacon in beacons {
                let beaconInfo: BeaconInfo = (beacon.uuid.uuidString, beacon.major.intValue, beacon.minor.intValue)
                let isContain: Bool = detectedBeaconList.contains { (element) -> Bool in
                    if element == beaconInfo {
                        return true
                    } else {
                        return false
                    }
                }
                
                switch beacon.proximity {
                case .unknown:
                    //beacon과 사용자의 접근 거리를 정확히 파악할 수 없는 경우
                    print("[\(beacon.major.intValue), \(beacon.minor.intValue)] proximity: unkown")
                case .far:
                    //beacon과 사용자의 접근 거리가 먼 경우
                    print("[\(beacon.major.intValue), \(beacon.minor.intValue)] proximity: far")
                    
                    if !isContain {
                        detectedBeaconList.append(beaconInfo)
                        detectedBeaconInfo = beaconInfo
                    }
                case .near:
                    //beacon과 사용자의 접근 거리가 가까운 경우
                    print("[\(beacon.major.intValue), \(beacon.minor.intValue)] proximity: near")
                    
                case .immediate:
                    //beacon과 사용자가 바로 근처에 있는 경우
                    print("[\(beacon.major.intValue), \(beacon.minor.intValue)] poximity: immediate")
                @unknown case _:
                    //그 외의 데이터가 전달되는 경우
                    print("[\(beacon.major.intValue), \(beacon.minor.intValue)] unkown data")
                }
            }
        } else {
            print("locationManager(_:didRangeBeacons:in:) - CLBeacon not found")
        }
    }
    
    //MARK: - Beacon이 탐지 범위 내에 진입한 경우 호출하는 함수
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("witnin range")
    }
    
    //MARK: - Beacon이 탐지 범위를 벗어나는 경우 호출하는 함수
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("out of range")
    }
}
