test_apps = \
            tests/add \
            tests/sub \

run_tests: $(test_apps)
	tests/add
	tests/sub
