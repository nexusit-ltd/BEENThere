pragma solidity ^0.8.0;

contract GeoReport {
    // Store the georeport data received from the off-chain component
    struct GeoReportData {
        bytes32[] beacons;
        uint256 latitude;
        uint256 longitude;
        uint256 startTime;
        uint256 endTime;
    }

    // Mapping from a unique identifier to the GeoReportData
    mapping(bytes32 => GeoReportData) public geoReports;

    // Event emitted when a new georeport is added
    event GeoReportAdded(bytes32 indexed geoReportId);

    // Function to add a new georeport
    function addGeoReport(
        bytes32 geoReportId,
        bytes32[] memory beacons,
        uint256 latitude,
        uint256 longitude,
        uint256 startTime,
        uint256 endTime
    ) public {
        GeoReportData memory newGeoReport = GeoReportData({
            beacons: beacons,
            latitude: latitude,
            longitude: longitude,
            startTime: startTime,
            endTime: endTime
        });
        geoReports[geoReportId] = newGeoReport;
        emit GeoReportAdded(geoReportId);
    }

    // Function to verify if a specific beacon is present for a specific time window and GPS location
    function verifyBeacon(
        bytes32 geoReportId,
        bytes32 beacon,
        uint256 latitude,
        uint256 longitude,
        uint256 startTime,
        uint256 endTime
    ) public view returns (bool) {
        GeoReportData memory geoReport = geoReports[geoReportId];

        // Check if the provided latitude, longitude, startTime, and endTime match the geoReport
        if (
            geoReport.latitude != latitude ||
            geoReport.longitude != longitude ||
            geoReport.startTime != startTime ||
            geoReport.endTime != endTime
        ) {
            return false;
        }

        // Check if the provided beacon is present in the geoReport
        for (uint256 i = 0; i < geoReport.beacons.length; i++) {
            if (geoReport.beacons[i] == beacon) {
                return true;
            }
        }

        return false;
    }
}

