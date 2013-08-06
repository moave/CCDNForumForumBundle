Feature: User Topic Traversal
	In order to view, create and reply to topics.
	As an User
	I want to be able to view topics and create or reply to them.

    Background:
        Given I am logged in as "user"
        And there are following users defined:
          | email          | password | enabled  | role                |
          | admin@foo.com  | root     | 1        | ROLE_SUPER_ADMIN    |
          | user@foo.com   | root     | 1        | ROLE_USER           |
        And there are following forums defined:
          | name                      | order    |
		  | test_forum_f1             | 1        |
		  | test_forum_f2             | 2        |
		  | test_forum_f3             | 3        |
        And there are following categories defined:
          | name                      | order    | forum               |
          | test_category_fn_c1       | 1        |                     |
		  | test_category_fn_c2       | 2        |                     |
		  | test_category_fn_c3       | 3        |                     |
          | test_category_f1_c1       | 1        | test_forum_f1       |
		  | test_category_f1_c2       | 2        | test_forum_f1       |
		  | test_category_f1_c3       | 3        | test_forum_f1       |
          | test_category_f2_c1       | 1        | test_forum_f2       |
		  | test_category_f2_c2       | 2        | test_forum_f2       |
		  | test_category_f2_c3       | 3        | test_forum_f2       |
          | test_category_f3_c1       | 1        | test_forum_f3       |
		  | test_category_f3_c2       | 2        | test_forum_f3       |
		  | test_category_f3_c3       | 3        | test_forum_f3       |
        And there are following boards defined:
          | name                      | description          | order   | category              |
          | test_board_fn_cn_b1       | testing board 1      | 1       |                       |
          | test_board_fn_cn_b2       | testing board 2      | 2       |                       |
          | test_board_fn_cn_b3       | testing board 3      | 3       |                       |
          | test_board_fn_c1_b1       | testing board 1      | 1       | test_category_fn_c1   |
          | test_board_fn_c1_b2       | testing board 2      | 2       | test_category_fn_c1   |
          | test_board_fn_c1_b3       | testing board 3      | 3       | test_category_fn_c1   |
          | test_board_fn_c2_b1       | testing board 1      | 1       | test_category_fn_c2   |
          | test_board_fn_c2_b2       | testing board 2      | 2       | test_category_fn_c2   |
          | test_board_fn_c2_b3       | testing board 3      | 3       | test_category_fn_c2   |
          | test_board_fn_c3_b1       | testing board 1      | 1       | test_category_fn_c3   |
          | test_board_fn_c3_b2       | testing board 2      | 2       | test_category_fn_c3   |
          | test_board_fn_c3_b3       | testing board 3      | 3       | test_category_fn_c3   |
          | test_board_f1_c1_b1       | testing board 1      | 1       | test_category_f1_c1   |
          | test_board_f1_c1_b2       | testing board 2      | 2       | test_category_f1_c1   |
          | test_board_f1_c1_b3       | testing board 3      | 3       | test_category_f1_c1   |
          | test_board_f1_c2_b1       | testing board 1      | 1       | test_category_f1_c2   |
          | test_board_f1_c2_b2       | testing board 2      | 2       | test_category_f1_c2   |
          | test_board_f1_c2_b3       | testing board 3      | 3       | test_category_f1_c2   |
          | test_board_f1_c3_b1       | testing board 1      | 1       | test_category_f1_c3   |
          | test_board_f1_c3_b2       | testing board 2      | 2       | test_category_f1_c3   |
          | test_board_f1_c3_b3       | testing board 3      | 3       | test_category_f1_c3   |
          | test_board_f2_c1_b1       | testing board 1      | 1       | test_category_f2_c1   |
          | test_board_f2_c1_b2       | testing board 2      | 2       | test_category_f2_c1   |
          | test_board_f2_c1_b3       | testing board 3      | 3       | test_category_f2_c1   |
          | test_board_f2_c2_b1       | testing board 1      | 1       | test_category_f2_c2   |
          | test_board_f2_c2_b2       | testing board 2      | 2       | test_category_f2_c2   |
          | test_board_f2_c2_b3       | testing board 3      | 3       | test_category_f2_c2   |
          | test_board_f2_c3_b1       | testing board 1      | 1       | test_category_f2_c3   |
          | test_board_f2_c3_b2       | testing board 2      | 2       | test_category_f2_c3   |
          | test_board_f2_c3_b3       | testing board 3      | 3       | test_category_f2_c3   |
          | test_board_f3_c1_b1       | testing board 1      | 1       | test_category_f3_c1   |
          | test_board_f3_c1_b2       | testing board 2      | 2       | test_category_f3_c1   |
          | test_board_f3_c1_b3       | testing board 3      | 3       | test_category_f3_c1   |
          | test_board_f3_c2_b1       | testing board 1      | 1       | test_category_f3_c1   |
          | test_board_f3_c2_b2       | testing board 2      | 2       | test_category_f3_c1   |
          | test_board_f3_c2_b3       | testing board 3      | 3       | test_category_f3_c1   |
          | test_board_f3_c3_b1       | testing board 1      | 1       | test_category_f3_c1   |
          | test_board_f3_c3_b2       | testing board 2      | 2       | test_category_f3_c1   |
          | test_board_f3_c3_b3       | testing board 3      | 3       | test_category_f3_c1   |
        And there are following topics defined:
          | title                     | body                           | board                 | user          |
          | test_topic_f1_c1_b1_t1    | test_board_f1_c1_b1_t1_p1      | test_board_f1_c1_b1   | user@foo.com  |
		  | test_topic_f1_c1_b1_t2    | test_board_f1_c1_b1_t2_p1      | test_board_f1_c1_b1   | user@foo.com  |
          | test_topic_f1_c1_b1_t3    | test_board_f1_c1_b1_t3_p1      | test_board_f1_c1_b1   | user@foo.com  |
		  | test_topic_f1_c1_b2_t4    | test_board_f1_c1_b2_t4_p1      | test_board_f1_c1_b2   | user@foo.com  |
          | test_topic_f1_c1_b2_t5    | test_board_f1_c1_b2_t5_p1      | test_board_f1_c1_b2   | user@foo.com  |
		  | test_topic_f1_c1_b2_t6    | test_board_f1_c1_b2_t6_p1      | test_board_f1_c1_b2   | user@foo.com  |

	Scenario: See Boards topic list filtered by forum and board show
        Given I am on "/en/forum/test_forum_f1"
		  And I follow "test_category_f1_c1"
		  And I should see "test_category_f1_c1"
          And I should see "test_board_f1_c1_b1"
		  And I follow "test_board_f1_c1_b1"
          And I should see "test_board_f1_c1_b1"
		  And I should see "test_topic_f1_c1_b1_t1"
		  And I should see "test_topic_f1_c1_b1_t2"
		  And I should see "test_topic_f1_c1_b1_t3"
		  And I follow "test_topic_f1_c1_b1_t1"
		  And I should see "test_board_f1_c1_b1_t1_p1"
        Given I am on "/en/forum/test_forum_f1" 
		  And I follow "test_category_f1_c1"
		  And I should see "test_category_f1_c1"
          And I should see "test_board_f1_c1_b2"
		  And I follow "test_board_f1_c1_b2"
          And I should see "test_board_f1_c1_b2"
		  And I should see "test_topic_f1_c1_b2_t4"
		  And I should see "test_topic_f1_c1_b2_t5"
		  And I should see "test_topic_f1_c1_b2_t6"
		  And I follow "test_topic_f1_c1_b2_t4"
		  And I should see "test_board_f1_c1_b2_t4_p1"

