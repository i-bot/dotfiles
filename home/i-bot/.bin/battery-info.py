import utils

full_message = "<icon=bat_full_01.xbm/> 100% "
charging_message = "<icon=bat_low_01.xbm/> %s - %s "
discharging_message = "<fc=#ff0000><icon=bat_low_01.xbm/> %s - %s</fc> "

def get_acpi_out():
    acpi_out, success = utils.call_command(["acpi"])

    if not success or acpi_out == "":
        return None, None, success

    acpi_split = acpi_out.split(": ")[1].split(", ")

    return acpi_split[0], acpi_split[1:], success


if __name__ == "__main__":
    state, rest, success = get_acpi_out()
    if success:
        if state == "Full":
            print(full_message)
        if state == "Charging":
            remaining = rest[1].split(" ")[0]
            print(charging_message % (rest[0], remaining))
        if state == "Discharging":
            remaining = rest[1].split(" ")[0]
            if remaining == "rate":
                print(discharging_message % (rest[0], "..."))
            else:
                print(discharging_message % (rest[0], remaining))
