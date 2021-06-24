1. Document classification is a typical problem encountered in natural
language Processing (NLP). A document is classified based on the type of
words that occur in a document. It is possible to use Sparse PCA as an
unsupervised technique for document classification. News_post.mat
contains data collated from 16242 news postings on four different topics
(religion & politics, computers, science, and miscellaneous). For every
news posting, if a word occurs from a selected dictionary of 100 words, the
element of corresponding matrix is 1, otherwise zero. The matrix of size
100 x 16242 is stored in variable ‘documents’ as a sparse matrix. Note that
a sparse matrix only stores the row, column and value corresponding to
non-zero elements of the matrix, to reduce storage space. (There are
several commands in MATLAB that allow you to create sparse matrices as
well as access elements of sparse matrices which you can learn about using
help).
(a) Apply PCA to the documents data and determine the variance captured by
each of the first three PCs. Since every PC will be a weighted combination
of all 100 words, it is difficult to interpret whether a PC characterizes a
particular topic.
(b) Apply Sparse PCA to the documents data such that the first sparse PC
captures at least 75% of the variance captured by the first PC. For this
purpose increase the cardinality parameter until the adjusted variance
exceeds 75% of the variance captured by the first regular PC. Report the
number of non-zero coefficients obtained and the list of words from the
dictionary that are contained in the first sparse PC. Are you able to identify
the topic that the first sparse PC represents?
(c) Find the second sparse PC such that the cumulative adjusted variance of
the first two sparse PCs together capture at least 75% of the total variance
captured by the first two standard PCs. Report the number of non-zero
coefficients obtained for the second sparse PC and the list of words from
the dictionary that are contained in the second sparse PC. Are you able to
identify the topic that the second sparse PC represents?
2. The data set autocomp.mat contains the dimensions of 45 different attributes
of an automotive component. Measurements of seventy four samples are obtained
(all in mm). It is desired to find the top five dimensions which contribute to the
variability in the manufacture of this component. Using sparse PCA identify the
top five dimensions and report the percentage of total variance contributed by
these dimensions.
