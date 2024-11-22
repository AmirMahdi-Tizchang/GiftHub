from cs50 import SQL
import random

# Connect to the database
db = SQL("sqlite:///gifthub.db")  # Make sure the database is correctly connected


def suggest(year):
    # Get the names and IDs of children who haven't sent letters for the given year
    children = db.execute("""
        SELECT children.id, children.name
        FROM children
        LEFT JOIN letters ON children.id = letters.child_id
        WHERE letters.year IS NULL OR letters.year <> ?
    """, year)

    # Debug print statement
    print()
    print("Children without letters:")
    for i, child in enumerate(children):
        if i != len(children) - 1:
            print(f"{child['name']}", end=", ")
        else:
            print(f"{child['name']}", end=".")
    print()
    print()

    gift_assignments = []
    print("Process:")
    for child in children:
        child_id = child['id']
        child_name = child['name']
        last_year = year - 1

        # Get the last year's gift category for the child
        category_result = db.execute("""
            SELECT gifts.category
            FROM deliveries
            JOIN gifts ON deliveries.gift_id = gifts.id
            WHERE deliveries.child_id = ? AND deliveries.year = ?
        """, child_id, last_year)

        category = category_result[0]['category'] if category_result else None

        # Debug print statement
        if category:
            print(f"{child_name} - Last year's category: {category}", end=" & ")

            # Get a random gift from the specified category
            gifts = db.execute("""
                SELECT model
                FROM gifts
                WHERE category = ?
                AND quantity > 0
            """, category)

            if gifts:
                selected_gift = random.choice(gifts)['model']
                print(f"Selected gift: {selected_gift}")
                gift_assignments.append((child['name'], selected_gift))
            else:
                print(f"No available gifts in the category!")
                gift_assignments.append((child['name'], "No available gift"))
        else:
            print(f"{child_name} - No category found for last year")
            gift_assignments.append((child['name'], "Unknown desire"))

    return gift_assignments


if __name__ == "__main__":
    year = int(input("Enter the year: "))
    assignments = suggest(year)

    print("\nSummery:")
    for child, gift in assignments:
        print(f"{child}, Gift: {gift}")
