import sys
import xml.etree.ElementTree as ET
from pathlib import Path


def validate_results(result_file):
    file_path = Path(result_file)

    if not file_path.exists():
        print(f"Result file not found: {file_path}")
        return 1

    try:
        root = ET.parse(file_path).getroot()
    except ET.ParseError as error:
        print(f"Could not read Robot Framework results: {error}")
        return 1

    total = 0
    passed = 0
    failed = 0

    for test in root.iter("test"):
        status = test.find("status")

        if status is None:
            continue

        total += 1

        if status.get("status") == "PASS":
            passed += 1
        else:
            failed += 1

    print("")
    print("========================================")
    print("      ROBOT FRAMEWORK TEST SUMMARY")
    print("========================================")
    print(f"Result file:    {file_path}")
    print(f"Total tests:    {total}")
    print(f"Passed tests:   {passed}")
    print(f"Failed tests:   {failed}")
    print("========================================")
    print("")

    if total == 0:
        print("Quality Gate: FAILED - No tests were executed.")
        return 1

    if failed > 0:
        print("Quality Gate: FAILED")
        return 1

    print("Quality Gate: PASSED")
    return 0


if __name__ == "__main__":
    result_file = sys.argv[1] if len(sys.argv) > 1 else "results/output.xml"
    sys.exit(validate_results(result_file))