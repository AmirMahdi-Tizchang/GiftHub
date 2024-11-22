# GiftHub

Amirmahdi Tizchang

Video overview: <URL HERE> **[GiftHub](https://youtu.be/HC3Qw1ndv2s)**

## Scope

**Welcome to GiftHub: North Pole Gift Tracker!**

* **What is the purpose of your database?**

    > This project aims to streamline Santa's gift distribution process, ensuring that every child receives a special gift from the North Pole.

* **Which people, places, things, etc. are you including in the scope of your database?**

    > - **Children:** Every child who believes in Santa and expects a gift from the North Pole.
    > - **Gifts:** A wide range of gifts that Santa and his elves produce in the workshop.
    > - **Letters:** Letters written by children to Santa, expressing their wishes and desires for gifts.
    > - **Deliveries:** Records of gifts dispatched from the North Pole to children around the world.

* **Which people, places, things, etc. are *outside* the scope of your database?**

    > 1. **Non-believers:** Individuals who do not believe in Santa Claus and therefore do not participate in the tradition of receiving gifts from him.
    > 2. **Non-gift-related Events:** Events or activities unrelated to the gift-giving process, such as holiday decorations, reindeer grooming, or elf training programs.
    > 3. **Non-gift Items:** Items not produced or distributed by Santa's workshop, such as generic household goods or commercial products.
    > 4. **Non-gift-related Correspondence:** Correspondence unrelated to gift requests or the gift distribution process, such as general letters to Santa expressing non-gift-related sentiments.
    > 5. **Naughty Children's Letters:** Correspondence written by children who have been deemed "naughty" according to Santa's standards. These letters typically do not pertain to gift requests or the gift distribution process and are therefore not within the purview of our database.

## Functional Requirements

* **What should a user be able to do with your database?**

    > 1. **View Children's Information:** Users can access information about children, including their names, ages, locations, and naughty/nice status.
    > 2. **Manage Wish Lists:** Users can view and update wish lists submitted by children, including adding, removing, or modifying gift requests.
    > 3. **Track Gift Deliveries:** Users can monitor the status of gift deliveries, including which gifts have been dispatched, to whom, and when they were delivered.
    > 4. **Analyze Gift Data:** Users can analyze past gift data to gain insights into children's preferences and make informed decisions about gift distribution.
    > 5. **Retrieve Letter Content:** Users can access the content of letters written by children to Santa, providing context for gift requests and sentiments expressed by the children.
    > 6. **Generate Reports:** Users can generate reports summarizing gift distribution, wish list trends, delivery efficiency, and other relevant metrics.

* **What's beyond the scope of what a user should be able to do with your database?**

    > In addition to the core functionalities outlined above, our database system includes a unique feature to address situations where letters from children may be lost or not received. We understand that some children, despite being well-behaved and deserving of gifts, may not have the opportunity to submit their wish lists to Santa Claus. To ensure that no child is left without a gift, we've developed a Python program called `suggestion.py`.

    > The `suggestion.py` program operates by searching for children who have not submitted wish lists or whose letters may have been lost in transit. It does so by examining the delivery records in the database and identifying cases where gifts have not been dispatched to certain children. By cross-referencing this information with the history of gift deliveries, the program can pinpoint instances where children have been inadvertently overlooked or where letters may have gone missing.

    > Once these cases are identified, `suggestion.py` generates suggestions for gifts based on past gift data and children's demographics. This ensures that every child, regardless of whether they've submitted a wish list, receives a thoughtful and appropriate gift from Santa Claus.

    > This proactive approach underscores our commitment to ensuring that no child is left behind during the holiday season. Through the combination of our comprehensive database system and the innovative capabilities of `suggestion.py`, we're dedicated to spreading joy and cheer to children around the world, one gift at a time.

## Representation

### Entities

* **Which entities will you choose to represent in your database?**

    > The key entities in the database are:
    > - **Children:** Represented by their name, location, status (naughty/nice), and birthdate.
    > - **Gifts:** Each gift has a model name, description, category, and available quantity.
    > - **Letters:** These represent the letters sent by children, containing content and the year it was written.
    > - **Deliveries:** These track which gifts were delivered to which children and in which year.

* **What attributes will those entities have?**

    > - **Children:** `id`, `name`, `location`, `status`, `birth`.
    > - **Gifts:** `id`, `model`, `description`, `category`, `quantity`.
    > - **Letters:** `id`, `child_id`, `content`, `year`.
    > - **Deliveries:** `id`, `gift_id`, `child_id`, `year`.

* **Why did you choose the types you did?**

    > The types were chosen based on the nature of the data they represent. For instance:
    > - `name` and `location` are text fields as they store textual information.
    > - `status` is constrained to specific values ('naughty', 'nice') using a `CHECK` constraint.
    > - `quantity` is an integer, representing the count of available gifts, constrained to be non-negative.

* **Why did you choose the constraints you did?**

    > Constraints ensure data integrity. For example:
    > - The `status` constraint ensures that only valid statuses ('naughty', 'nice') are recorded.
    > - The `quantity` constraint ensures that gift quantities are always non-negative, preventing errors in inventory management.

### Relationships

![Diagram](https://mermaid.ink/svg/pako:eNqFUj1zwjAM_Ss-z5gfkLX0OpROdOplEbZIdCR2TpZ7zUH-e51AMWVo5UlPst7Tx0nb4FBX2hhTeyHpsFIvdJA27dXOtthD7ZcY8oagYehrr7I9tdQ5Rq-mYEw4LX-iqtQGO_pEJowPeaeLP9srjopc8XfC5BvloccCbkBQ7YmlLdg2WBAKXoHLNWMskWefehUFJF3BqcQu0v7n7_MkuoK-45coR9EyDTPpXT6KykKwCTz-Yrs1ez6v13koWxRBnsdS6_xKH1f8D02HwEiNN8eM27msuY8u2mzwgl4eRjYi8E2UXukeuQdyecULW60lLxVrPWtywMdZ15TzIEnYjd7qSjjhSnNITaurA3Qxe2lwufj1Am4oOpLAb5cLWg5ppQfwHyH85EzfG1q6Nw
"Relationships & Structure Diagram")

## Optimizations

* **Which optimizations (e.g., indexes, views) did you create? Why?**

    > - **Indexes:** Created indexes on `name`, `year` in `deliveries`, `year` in `letters`, and `model` in `gifts` to speed up queries that filter by these columns.
    > - **Views:** Created views like `Letters2024` for new letters and `Blank2024` for children who haven't written letters, to simplify and optimize querying for specific year-based data.

## Limitations

* **What are the limitations of your design?**

    > The current design primarily supports tracking gift deliveries based on historical data, and it assumes that every child who has not written a letter should receive a gift suggestion. However, it may not accurately capture complex gift-giving scenarios, such as children receiving multiple gifts in different categories or handling custom gift requests that do not fit predefined categories.

* **What might your database not be able to represent very well?**

    > The database may struggle with scenarios involving large-scale changes in gift categories, custom gifts that fall outside predefined categories, or handling gifts for children who may move between "naughty" and "nice" statuses frequently within the same year. Additionally, it assumes that all gifts fit neatly into the existing categories, which might not be true as new types of gifts emerge.
