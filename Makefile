TEST_SHs = $(shell find . -name test.sh)
TEST_SH_RUNs = $(addsuffix .run,${TEST_SHs})

tests: ${TEST_SH_RUNs}
%/test.sh.run: %/test.sh
	cd ${<D}; bash $(<F)
